from setuptools import setup, find_packages

import os
import versioneer

here = os.path.abspath(os.path.dirname(__file__))
with open(os.path.join(here, 'README.rst'), encoding='utf-8') as f:
    long_description = f.read()


setup(
    name='pandoctools',
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),

    description='Profile manager of text processing pipelines: Pandoc filters, any text CLI filters. Atom+Markdown+Pandoc+Jupyter workflow, export to ipynb.',
    long_description=long_description,

    url='https://github.com/kiwi0fruit/pandoctools',

    author='Peter Zagubisalo',
    author_email='peter.zagubisalo@gmail.com',

    license='MIT',

    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Developers',
        'Topic :: Software Development :: Build Tools',
        'License :: OSI Approved :: MIT License',

        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.6',
    ],

    # keywords='sample setuptools development',
    packages=find_packages(exclude=['docs', 'tests']),

    install_requires=['click', 'pyyaml', 'panflute>=1.11.1', 'knitty>=0.4.7', 'pandas',
                      'sugartex>=0.1.12', 'notebook', 'jupyter', 'shortcutter>=0.1.8'],

    include_package_data=True,
    package_data={
        'pandoctools': ['sh/*'],
    },
    entry_points={
        'console_scripts': [
            'cat-md=pandoctools.cat_md.cat_md:cli',
            'pandoctools=pandoctools.cli.cli:pandoctools',
            'pandoc-filter-arg=pandoctools.pandoc_filter_arg.cli:cli',
            'pandoctools-resolve=pandoctools.pandoctools_resolve.resolve:cli',
        ],
    },
    scripts=[
        'scripts/pandoctools-path-source',
        'scripts/pandoctools-path-pyprep',
        'scripts/pandoctools-path-pyprep-win',
        'scripts/pandoctools-cygpath',
    ],
)
