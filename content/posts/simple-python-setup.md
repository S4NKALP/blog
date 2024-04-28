+++
date = 2024-04-24T00:40:16+02:00
title = "Simple Python App Setup 👨‍💻</> "
description = "How to setup a simple project for Python apps"
tags = ["tutorial", "python", "macos", "linux"]
type = "post"
showTableOfContents = true
+++

## Introduction

Many tutorials show you how to create a basic Python app with a couple of modules, but they rarely explain how to set up a whole project.

This guide will show you how to set up a simple Python project with automated testing and a [virtual environment](https://docs.python.org/3/tutorial/venv.html) for 3rd party packages. I have based it on [Dead Simple Python: Project Structure and Imports](https://dev.to/codemouse92/dead-simple-python-project-structure-and-imports-38c6) by [Jason C. McDonald](https://dev.to/codemouse92) with some opinionated changes.

This guide has been tested on MacOS and GNU/Linux.

## Setup

### Download Python

First, you need to install Python. On MacOS, you can install it with [Homebrew](https://brew.sh/). Do not use the Python version that comes pre-installed with MacOS, as it's not only outdated but also integral to the OS.

```bash
brew install python3
```

Then, ensure it's installed by running:

```bash
python3 --version
```


### Create a Python Project

Create a new directory for your project and `cd` into it (e.g., `calculator`, `myapp`, etc.).

```bash
mkdir sample
cd sample
```

Create a directory for your Python code, giving it the same name as your project to create a [top-level package](https://stackoverflow.com/questions/7948494/whats-the-difference-between-a-module-and-package-in-python). Avoid using hyphens in the name (e.g., `sample-project` is not acceptable). Instead, use a single word (e.g., `sample`) or underscores (e.g., `sample_project`) if they improve readability.

```bash
mkdir sample
```

Create a bunch of Python modules in the top-level package.

```bash
touch sample/__init__.py
touch sample/__main__.py
touch sample/app.py
```

You should have the following directory structure.

```
[~/sample] $ tree
.
└── sample
    ├── __init__.py
    ├── __main__.py
    └── app.py
```

Add the following to `sample/app.py`.

```python
def run() -> None:
    print("Hello World!")
```

Add the following to `sample/__main__.py`.

```python
from sample import app


def main() -> None:
    app.run()


if __name__ == "__main__":
    main()
```

Run the app.

```bash
python3 -m sample
```

```
Hello World!
```

Now let's go step by step through what you did.

1. You created a top-level package in the root of your project. It has the same name as your project (e.g., `~/sample/sample`).
    ```bash
    mkdir sample
    ```

2. You created a bunch of Python modules in the top-level package directory. Each package must contain an `__init__.py`. The `__main__.py` serves as the entry point to the app and `app.py` houses the actual app's logic. While you could technically put everything from `app.py` inside `__main__.py`, I prefer to keep `__main__.py` small, much like in my C++ projects. That is to say, `app.py` isn't mandatory, but it helps keep `__main__.py` tidy.
    ```bash
    touch sample/__init__.py
    touch sample/__main__.py
    touch sample/app.py
    ```

3. In `sample/app.py`, you defined a `run()` function that prints `Hello World!`.
    ```python
    def run() -> None:
        print("Hello World!")
    ```

4. In `sample/__main__.py`, you used absolute imports to import the `app` module from the top-level `sample` package. You then defined a `main()` function. This function executes when the script is ran directly using `python3 -m sample`.
    ```python
    from sample import app


    def main() -> None:
        app.run()


    if __name__ == "__main__":
        main()
    ```


### Create Subpackages

You can create subpackages in the top-level package directory. For example, you can create a `core` (or `common`) package that contains the core logic of your app (imported often by various modules), an `io` package that contains input/output logic (e.g., reading from disk), a `tests` package that contains tests (optional), and a `utils` package that contains utility functions (e.g., normalizing and tokenizing a string).

Create a bunch of subpackages in the top-level package directory.

```bash
mkdir sample/core
mkdir sample/io
mkdir sample/tests
mkdir sample/utils
```

Add `__init__.py` to each of the subpackages.

```bash
touch sample/core/__init__.py
touch sample/io/__init__.py
touch sample/tests/__init__.py
touch sample/utils/__init__.py
```

Create two modules in the `core` and `io` subpackages: `config.py` and `disk.py`.

```bash
touch sample/core/config.py
touch sample/io/disk.py
```

You should have the following directory structure.

```
[~/sample] $ tree
.
└── sample
    ├── __init__.py
    ├── __main__.py
    ├── app.py
    ├── core
    │   ├── __init__.py
    │   └── config.py
    ├── io
    │   ├── __init__.py
    │   └── disk.py
    ├── tests
    │   └── __init__.py
    └── utils
        └── __init__.py
```

Add the following to `sample/core/config.py`.

```python
verbose: bool = True
```

Add the following to `sample/io/disk.py`.

```python
from sample.core import config


def write_to_disk(
    file_path: str,
    data: str,
) -> None:
    with open(file_path, mode="w", encoding="utf-8") as f:
        if config.verbose:
            print(f"Writing data to '{file_path}'")
        f.write(data)
```

Modify `sample/app.py` to use the `write_to_disk()` function.

```python
from sample.io.disk import write_to_disk


def run() -> None:
    write_to_disk("output.txt", "Hello World!\n")
```

Now if you run the app, an `output.txt` file will be created with the content `Hello World!` in your CWD. Since the global `verbose` variable is set to `True`, the function will print a message to the console.

```bash
python3 -m sample
```

```
Writing data to 'output.txt'
```

Now let's go step by step through what you did.

1. You created a bunch of subpackages in the top-level package directory. Every package must contain an `__init__.py` file.
    ```bash
    mkdir sample/core
    mkdir sample/io
    mkdir sample/tests
    mkdir sample/utils
    touch sample/core/__init__.py
    touch sample/io/__init__.py
    touch sample/tests/__init__.py
    touch sample/utils/__init__.py
    ```

2. You created two modules in the `core` and `io` subpackages.
    ```bash
    touch sample/core/config.py
    touch sample/io/disk.py
    ```

3. In `sample/core/config.py`, you defined a `verbose` variable that can be set to `True` or `False` to control the verbosity of the program. This module contains global variables that can be read and modified by the program.
    ```python
    verbose: bool = True
    ```

4. In `sample/io/disk.py`, you used absolute imports to import the `config` module from the `core` subpackage. You then defined a `write_to_disk()` function. This function writes data to a file on disk. If the `config.verbose` variable is set to `True`, the function prints a message to the console.
    ```python
    from sample.core import config


    def write_to_disk(
        file_path: str,
        data: str,
    ) -> None:
        with open(file_path, mode="w", encoding="utf-8") as f:
            if config.verbose:
                print(f"Writing data to '{file_path}'")
            f.write(data)
    ```


### Create Tests

You can create [unit tests](https://docs.python.org/3/library/unittest.html) for your app. First, let's create something to test.

Create a `sample/utils/case.py` module.

```bash
touch sample/utils/case.py
```

Add the following to `sample/utils/case.py`.

```python
def lower(
    text: str,
) -> str:
    return text.lower()
```

Create a `sample/tests/test_case.py` module. The file name must start with `test_` to be discovered by the test runner (which you will see later).

```bash
touch sample/tests/test_case.py
```

Add the following to `sample/tests/test_case.py`. You should have a test (beginning with `test_`) for each function in the `case.py` module. The test methods must be independent of each other and you can have multiple [assert methods](https://docs.python.org/3/library/unittest.html#assert-methods) within a single test method.

```python
import unittest

from sample.utils import case


class TestCase(unittest.TestCase):
    def test_lower(
        self,
    ) -> None:
        self.assertEqual(case.lower("HELLO"), "hello")
        self.assertEqual(case.lower("WORLD"), "world")
        self.assertEqual(case.lower("GitHub"), "github")


if __name__ == "__main__":
    unittest.main()
```

You should have the following directory structure.

```
[~/sample] $ tree
.
├── output.txt
└── sample
    ├── __init__.py
    ├── __main__.py
    ├── app.py
    ├── core
    │   ├── __init__.py
    │   └── config.py
    ├── io
    │   ├── __init__.py
    │   └── disk.py
    ├── tests
    │   ├── __init__.py
    │   └── test_case.py
    └── utils
        ├── __init__.py
        └── case.py
```

Now you can run the tests. This will run all the tests in the `sample/tests` package.

```bash
python3 -m unittest discover sample.tests
```


### Create Virtual Environment

If you use any third-party libraries, you should create a [virtual environment](https://docs.python.org/3/tutorial/venv.html) to avoid conflicts with other projects. It might seem inconvenient at first, but you'll get used to it. Do not install third-party libraries globally.

Create a new directory for your virtual environments.

```bash
mkdir -p ~/.local/env/
```

Create a Python virtual environment for the project. The name of the virtual environment should be the same as the name of the project.

```bash
python3 -m venv ~/.local/env/sample
```

Activate the virtual environment. You have to do this every time you open a new terminal. In VSCode, you can [set the Python interpreter manually](https://code.visualstudio.com/docs/python/environments#_manually-specify-an-interpreter) to `~/.local/env/sample/bin/python3` and then enable `python.terminal.activateEnvInCurrentTerminal` to do this automatically.

```bash
. ~/.local/env/sample/bin/activate
```

Create a `requirements.txt` file with the required dependencies in the root of your project.

```bash
touch requirements.txt
```

Add the following to `requirements.txt`.

```
loguru
```

Install the required dependencies from the `requirements.txt` file. You can `pip3 install` the dependencies yourself but the point of `requirements.txt` is to make it easier for others to install the dependencies required for your project.

```bash
pip3 install -r requirements.txt
```

Modify `sample/__main__.py` to use the `loguru` for logging.

```python
from loguru import logger

from sample import app


def main() -> None:
    logger.info("Running app")
    app.run()
    logger.success("App ran successfully")


if __name__ == "__main__":
    main()
```

Now if you run the app, you will see log messages in the console.

```bash
python3 -m sample
```

```
2024-04-23 19:12:41.410 | INFO     | sample.__main__:main:7 - Running app
Writing data to 'output.txt'
2024-04-23 19:12:41.411 | SUCCESS  | sample.__main__:main:9 - App ran successfully
```

That's it.


## Final Thoughts

This guide should give you a basic understanding of how to set up a simple Python project with automated testing and a virtual environment for 3rd party packages.
