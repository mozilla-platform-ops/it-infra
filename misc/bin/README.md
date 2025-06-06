# Scripts
## Setup
At the root of the repo, run:
```
pip install -r requirements.txt
```

## new-project
A script to template a new project from the skeleton directory at `misc/skeletons`.

```
$ ./misc/bin/new-project --help
Usage: new-project [OPTIONS] NAME

Options:
  --risk TEXT                   [required]
  --overwrite / --no-overwrite  Overwrite pre-existing files. By default files
                                that do not exist will be written.
  --help                        Show this message and exit.
```