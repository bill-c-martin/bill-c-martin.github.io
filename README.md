**Source** code for my [Jekyll](https://jekyllrb.com/)-based portfolio at [billmartin.io](https://billmartin.io), which uses the [Freelancer Jekyll Theme](https://github.com/jeromelachaud/freelancer-theme) with my own additions and modifications.

Demo: [bill-c-martin.github.com](https://bill-c-martin.github.io)

Requires no servers or hosting, and runs straight from your GitHub repo on GitHub Pages.

## Quick Setup

1. Fork this repo to your own Github, with name: ```your-github-username.github.io```
2. Open your new repo's settings, and enable [Github Pages](https://pages.github.com/)
3. Go to https://your-github-username.github.io

## Localhost Setup

Localhost setup uses VS Code Dev Containers.

> **Note**
> If you don't want to use Docker or VS Code, [an older version of this README](https://github.com/bill-c-martin/bill-c-martin.github.io/blob/c8ff940d5b8776e1cc6fa9b906c066f06da580a5/README.md) has manual ruby & gem installation instructions.

### Prerequisites

- Docker (For Windows, also install: wsl, Ubuntu, and Docker Desktop)
- VS Code
- VS Code extensions:
  - Dev Containers
  - Markdown All in One (recommended)
  - GitHub Markdown Preview (recommended)
  - markdownlint (recommended)

### Instructions

1. Clone the above repo, which you forked, to your localhost
2. Open the repo in VS Code and click the "Reopen in Container" button that pops up

> **Note:**
> Or run `Dev Containers: Open Folder in Container...` in the command palette (`Ctrl+Shift+P`)

3. When the container is done provisioning, hit any key to continue
4. Start the web server:

```bash
bundle exec jekyll serve
```

5. Go to [http://localhost:4000](http://localhost:4000) and verify it runs locally.

The localhost site will show changes in real-time.

If you modify `_config.yml` though, you'll need to `ctrl+c` and restart the web server.

### Debugging

Pipe any variable into `debug` from any template to see its contents on screen.

Example: Printing entire _config.yml structure:

```ruby
{{ site | debug }}
```

Example: Printing blog post attribute from inside a for loop in `blog_grid.html`:

```ruby
{{ post | debug }}
```

## Configuration

Once up and running locally, configure and personalize your portfolio.

### Personalization

1. Overwrite profile picture in `img/profile.jpg` (used on home page) and `img/profile32x32.png` (used on blog posts)
2. Fill out everything in `_config.yml`
3. Create new posts to display your projects & blog posts. See existing examples in ```_posts/blog/``` and ```_posts/portfolio/```

### Contact Form Setup

Formspree will receive POST requests from your contact form, and forward them to your email. Without requiring server-side code.

1. Replace `you@email.com` in `_includes/contact_static.html` with your email address
2. Setup a [formspree](https://formspree.io/) account for your email address

### Comments Setup

Disqus will receive POST requests from your blog post's comment forms, display comments dynamically, and also deal with spam. Without requiring server-side code.

1. Setup a [Disqus](https://help.disqus.com/customer/portal/articles/466208) account
2. Add your `disqus_shortname` in `_config.yml`

### Deployment

1. Push above code changes on `master` branch to remote
2. Go to https://your-github-username.github.io

## Extras

These are some recommended steps for final polishing.

### Google Analytics Setup

1. Create a [Google Analytics](https://analytics.google.com/analytics/web/) site/property
2. Enter your `google_analytics_tracker_id` in `_config.yml`

### Google Tag Manager

1. Create a Google Tag Manager](https://tagmanager.google.com/) container
2. Enter your `gtm_id` in `_config.yml`

If you go this route, you can setup a GA4 tag through GTM, and forego the above "Google Analytics Setup" route.

### Custom Domains

Instead of using the default https://your-github-username.github.io Github Pages URL, you can instead use your own custom domain name that you already own.

You can alias a custom domain name to your https://your-github-username.github.io Github Pages URL. See [Github's documentation](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site) on this.

However, you will usually have to manage and pay for an SSL certificates through your domain registrar.

You can instead use Netlify for all of this, for free.

#### Using Netlify (Free)

Netlify is a free service that provides CDN, SSL certs, deployment pipelines, and even dynamic serverless functions.

1. Create a [Netlify](https://www.netlify.com/) account
2. [Setup your custom domain](https://docs.netlify.com/domains-https/custom-domains/) to route through Netlify, and from Netlify to your repo
2. [Setup a Netlify SSL cert](https://docs.netlify.com/domains-https/https-ssl/)
