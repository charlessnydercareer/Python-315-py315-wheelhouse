# py315-wheelhouse

Reusable Python 3.15 **cp315** wheelhouse for native dependencies, including full-API **`ormsgpack`**.

## Purpose

This repository provides prebuilt Python 3.15 wheels so new Ubuntu machines can install projects without rebuilding native dependencies from source.

## Baseline

- Python: **`3.15.0b1`**
- Wheelhouse target: **`$HOME/.cache/py315-wheels`**

## Important native dependency rule

**`ormsgpack`** must be installed as a **`cp315-cp315`** wheel built against the **full CPython C API**.

Do **not** globally set:

```bash
PYO3_USE_ABI3_FORWARD_COMPATIBILITY=1
```

That flag forces or encourages **limited C API** behavior and can break **`ormsgpack`** source builds.

## Install

Wheel binaries are stored with **Git LFS** (`*.whl`), including **`grpcio`** (~195 MB), which exceeds GitHub's 100 MB blob limit. Install [Git LFS](https://git-lfs.com/) first (`git lfs install`), then clone:

```bash
git lfs install
git clone https://github.com/charlessnydercareer/Python-315-py315-wheelhouse.git
cd Python-315-py315-wheelhouse
chmod +x install_wheelhouse.sh
./install_wheelhouse.sh
```

Wheels ship under **`wheels/`**; the install script copies them into the standard cache path.

Override the destination with **`WHEELHOUSE_DEST`** if needed (default is **`$HOME/.cache/py315-wheels`**).

## Usage

```bash
$(command -v python3.15) -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip setuptools wheel
python -m pip install \
  --find-links "$HOME/.cache/py315-wheels" \
  -e ".[dev,langchain]"
python -c "import ormsgpack; print(ormsgpack.__version__)"
python -m pytest -q
pip check
```

## License

MIT License. See [LICENSE](LICENSE).
