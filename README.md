# S4NKALP BLOGS

S4NKALP BLOGS is a personal website built with [Hugo](https://gohugo.io/) that uses the [Gokarna](https://github.com/526avijitgupta/gokarna) theme.

The website is hosted on [GitHub Pages](https://pages.github.com/) and is accessible via the custom domain [S4NKALP BLOGS](https://S4NKALP.github.io/blog/).


## Motivation

I wanted a personal blog to share my thoughts with the world. I chose Hugo because it allows me to write content in Markdown and generate static HTML files that can be hosted on GitHub Pages.

I also included a manual theme update script, because I couldn't get the theme to update automatically using git submodules when using GitHub Actions.


## Features

- Automatic rebuilds using GitHub Actions.
- Easy content management with Markdown.


## Project Structure

The project is organized as follows:

- `.github`: Contains GitHub Actions workflows (for automatic rebuilds).
- `archetypes`: Contains templates for new posts (e.g., title, date).
- `assets`: Contains static assets (e.g., images).
- `content`: Contains the actual content of the website (posts).
- `data`: Contains configuration files (e.g., JSON, TOML, YAML).
- `i18n`: Contains internationalization files for multilingual websites.
- `layouts`: Contains templates for the website.
- `public`: Contains the generated static files.
- `static`: Contains static files (e.g., CSS, JavaScript).
- `themes`: Contains the theme used by the website.


## Tested Systems

This project has been tested on the following systems:

- Arch Linux


## Requirements

To run this project, you'll need:

- Hugo


## Build

Follow these steps to build the project:

1. **Clone the repository**:
    ```bash
    git clone https://github.com/S4NKALP/blog
    ```

2. **Update the Gokarna theme**:
    ```bash
    cd blog
    chmod +x update-theme.sh
    ./update-theme.sh
    ```

3. **Build the project (generate static files)**:
    ```bash
    hugo
    ```

After successful build, you can access the generated static files in the `public` directory.


## Usage

To create a new post:

```bash
hugo new posts/title.md
```

To start the Hugo server and view changes in real-time:

```bash
hugo server
```

To build the site and generate static files:

```bash
hugo
```

To update the Gokarna theme:

```bash
./update-theme.sh
```


## Contributing

All contributions are welcome.


## License

This project is licensed under the GNU GPLv3 License.


## Credits

- [Hugo](https://gohugo.io/)
- [Gokarna](https://github.com/526avijitgupta/gokarna)
