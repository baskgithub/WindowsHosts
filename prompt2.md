Create a Batch file for windows:
1. Download the file from `https://raw.hellogithub.com/hosts` to local temp, named `remote-hosts`.
2. Open the hosts file, denoted as `A`, in `C:\Windows\System32\drivers\etc\hosts` and find the first occurence of string1 `### Github Start` and  string2 `### Github End`, denote their positions as `point1` and `point2`;
2. If found them both, split the hosts file into 2 parts named: 
`A1.txt`: from beginning of `A` to `point1`;
`A2.txt`: from `point2` to the end of `A`;
3. concatenate file `A1.txt`, `remote-hosts` and `A2.txt` in order to one file denoted as `C`;
4. if not found string1 or string2, print a message, and concatenate `A` and `remote-hosts` as `C`
5. move `C` to overwrite `C:\Windows\System32\drivers\etc\hosts`
sample of A.txt
```
1
2
3

### Github Start
6
7
8

### Github End
11
12
13
14

```
