# paul-cd-project

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)  
[![GitHub Stars](https://img.shields.io/github/stars/paul-shuvro/paul-cd-project.svg)](https://github.com/paul-shuvro/paul-cd-project/stargazers) 

## Overview

**paul-cd-project** is a compiler design project implemented in **C**, demonstrating the construction of a lexical analyzer and parser using `lex` and `yacc` tools. It serves as a practical learning exercise for parsing techniques and fundamental compiler construction concepts in academic settings.

The project includes:
- Lexical analysis (`lexer.l`)
- Syntax parsing (`parser.y`)
- Core implementation in C (`main.c`, `lexer.c`)
- Build automation via a simple `Makefile`

This repository is structured to help you understand the core phases of a compiler and how to integrate tools like **Flex** and **Bison** into a C-based workflow. :contentReference[oaicite:1]{index=1}

---

## Table of Contents

- [Features](#features)  
- [Prerequisites](#prerequisites)  
- [Installation](#installation)  
- [Usage](#usage)  
- [Project Structure](#project-structure)  
- [Examples](#examples)  
- [Contributing](#contributing)  
- [License](#license)  
- [Contact](#contact)

---

## Features

This project implements:

- A **lexical tokenizer** that identifies tokens from source text
- A **grammar parser** that checks syntax structure
- A **driver module** (`main.c`) tying together lexer and parser
- Comprehensive use of `lex`/`flex` and `yacc`/`bison`
- Easy build process using `Makefile`

---

## Prerequisites

Before building and running the project, ensure you have installed:

- GCC or another C compiler
- **Flex** (Fast Lexical Analyzer)
- **Bison** (GNU Parser Generator)
- GNU Make

On Ubuntu/Debian systems, you can install dependencies with:

```bash
sudo apt update
sudo apt install build-essential flex bison
