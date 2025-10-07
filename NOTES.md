# Important Notes

## Check for 16 KB ELF alignment
Check the alignment of ELF segments for shared libraries For any shared libraries, verify that the shared libraries' ELF segments are aligned properly using `16 KB ELF alignment`. If you are developing on either Linux or macOS, you can use the check_elf_alignment.sh script as described in the following section.

Run this command to make this script runnable

```sh
chmod +x en_check_elf_alignment.sh
```
If you are in a flutter app—

Then
```sh
./en_check_elf_alignment.sh build/app/outputs/apk/release/app-release.apk
```