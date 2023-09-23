import glob
import logging
import os
import shutil
import sys
from argparse import ArgumentParser
from sphinx_runpython.runpython import run_cmd


def filter_line(line):
    if "viz.js" in line:
        return False
    return True


def filter_err(err):
    lines = err.split("\n")
    lines = [line for line in lines if filter_line(line)]
    return ("\n".join(lines)).strip("\n\r ")


def generate_doc(module, root=None, dest=None):
    this = os.path.abspath(os.path.dirname(__file__))
    if root is None:
        root = os.path.normpath(os.path.join(this, "..", ".."))
    root_module = os.path.join(root, module)
    if dest is None:
        dest = os.path.normpath(
            os.path.join(this, "..", "..", "sdpython.github.io/doc/")
        )

    cwd = os.getcwd()
    print()
    print("-------------------------------------")
    print("-------------------------------------")
    print(f"Generate documentation for {module!r}")
    print("-------------------------------------")
    print("-------------------------------------")
    name = module.replace("-", "_")
    mod = __import__(name)
    version = mod.__version__

    dev = os.path.join(dest, module, "dev")
    if "dev/v" in dev:
        raise RuntimeError(f"Wrong folder {dev!r}.")
    if not os.path.exists(dev):
        print(f"create folder (1) {dev!r}")
        os.makedirs(dev)
    print(f"PATH: {root_module}")
    print(f"DEST: {dest}")
    print(f"MODULE: {name!r}")
    print(f"VERSION: {version!r}")
    module_path = os.path.join(dest, module)
    print(f"module_path: {module_path!r}")

    cmds = [
        "cp LICENSE.txt _doc",
        "cp CHANGELOGS.rst _doc",
        "python3 -m sphinx _doc dist/html",
        f"rm -rf {module_path}/dev/",
        ["cp", f"{root_module}/dist/html/", f"{module_path}/dev/"],
        f"rm -rf {module_path}/v{version}/",
        ["cp", f"{root_module}/dist/html/", f"{module_path}/v{version}/"],
    ]

    for c in cmds:
        os.chdir(root_module)
        print()
        print(f"RUN: {c}")
        if isinstance(c, list):
            # copy
            copied = 0
            if "dev/v" in c[2]:
                raise RuntimeError(f"Wrong folder {c[2]!r}.")
            if not os.path.exists(c[2]):
                print(f"create folder (3) {c[2]!r}")
                os.makedirs(c[2])
            for name in glob.glob(f"{c[1]}/**", root_dir=c[1], recursive=True):
                if os.path.isdir(name):
                    continue
                rel = os.path.relpath(name, c[1])
                to = os.path.join(c[2], rel)
                d = os.path.dirname(to)
                if "dev/v" in d and not "dev/varie" in d:
                    raise RuntimeError(f"Wrong folder {d!r}.")
                if not os.path.exists(d):
                    print(f"create folder (4) {d!r}")
                    os.makedirs(d)
                shutil.copy(name, d)
                copied += 1
            print(f"COPIED: {copied}")
        else:
            out, err = run_cmd(
                c,
                wait=True,
                logf=print,
                log_error=print,
                communicate=False,
                shell="*" in c,
            )
            if filter_err(err):
                print("-- STDOUT --")
                print(out)
                print("-- STDERR --")
                print(err)
                print("##################################################")
                print("ERROR")
                print("##################################################")
                os.chdir(cwd)
                sys.exit(1)
    os.chdir(cwd)


if __name__ == "__main__":
    import logging

    for name in [
        "matplotlib.font_manager",
        "PIL.PngImagePlugin",
        "matplotlib",
        "matplotlib.pyplot",
        "blib2to3.pgen2.driver",
    ]:
        log = logging.getLogger(name)
        log.setLevel(logging.ERROR)
        
    parser = ArgumentParser(
        prog="update_doc.py", description="Generate the documentation for a module"
    )
    parser.add_argument("module", help="module name")
    args = parser.parse_args()

    generate_doc(args.module)
