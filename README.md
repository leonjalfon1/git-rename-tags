# git-rename-tags
Script to rename repository tags by adding a prefix

---

## DESCRIPTION

Script to rename all tags adding a prefix to the tag name.  
For example (using prefix "prefix-"):

```
mytag --> prefix-mytag
v1 --> prefix-v1
bugfix2 --> prefix-bugfix2
```

## USAGE

From git bash terminal:

```
$ bash rename-tags.sh <tag-prefix> <repository-url>
```

Example:

```
$ bash rename-tags.sh "prefix-" "https://github.com/leonjalfon1/git-rename-tags.git"
```
