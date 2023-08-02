import glob
import os
import shutil
import sys
from argparse import ArgumentParser
from sphinx_runpython.runpython import run_cmd

def filter_err(err):
    lines = err.split("\n")
    lines = [line for line in lines if "[gdot] viz.js" not in line]
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
    path = os.path.join(root, module)
    print()
    print("-------------------------------------")
    print(f"Generate documentation for {module!r}")
    name = module.replace("-", "_")
    mod = __import__(name)
    version = mod.__version__

    dev = os.path.join(dest, module, "dev")
    if not os.path.exists(dev):
        os.makedirs(dev)
    vers = os.path.join(dest, "dev", f"v{version}")
    if not os.path.exists(vers):
        os.makedirs(vers)
    print(f"PATH: {root_module}")
    print(f"DEST: {dest}")
    print(f"MODULE: {name!r}")
    print(f"VERSION: {version!r}")
    module_path = os.path.join(dest, module)

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
            if not os.path.exists(c[2]):
                os.makedirs(c[2])
            for name in glob.glob(f"{c[1]}/**", root_dir=c[1], recursive=True):
                if os.path.isdir(name):
                    continue
                rel = os.path.relpath(name, c[1])
                to = os.path.join(c[2], rel)
                d = os.path.dirname(to)
                if not os.path.exists(d):
                    os.makedirs(d)
                shutil.copy(name, d)
                copied += 1
            print(f"COPIED: {copied}")
        else:
            out, err = run_cmd(c, wait=True, logf=print, log_error=print, communicate=False, shell="*" in c)
            if filter_err(err):
                print("-- STDOUT --")
                print(out)
                print("-- STDERR --")
                print(err)
                os.chdir(cwd)
                sys.exit(1)
    os.chdir(cwd)


if __name__ == "__main__":
    parser = ArgumentParser(
        prog="update_doc.py", description="Generate the documentation for a module"
    )
    parser.add_argument("module", help="module name")
    args = parser.parse_args()

    generate_doc(args.module)
