from os import getenv
from keyrings.cryptfile.cryptfile import CryptFileKeyring
kr = CryptFileKeyring()
kr.keyring_key = getenv("KEYRING_CRYPTFILE_PASSWORD")
print(kr.get_password("web", "pyquickhelper,user"))
