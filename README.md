Source code for my [Jekyll](https://jekyllrb.com/)-based portfolio at [billmartin.io](http://billmartin.io), which uses the [Freelancer Jekyll Theme](https://github.com/jeromelachaud/freelancer-theme) with my own additions:

#### Resume Linking
The "Download Resume" button was added on the about page, which links to ```/resume/your-name-resume.pdf```

![Screenshot of "Download Resume" Button on About Page](/img/readme/resume_button.png)

#### Allow Blog Posts
In addition to the default portfolio posts, the ability to make blog posts has been added.

The new folder structure is:

![Screenshot of posts folder structure for blog and portfolio posts](/img/readme/posts_folder_structure.png)

![Screenshot of example blog grid view](/img/readme/blog_screenshot.png)

#### Support Tags on Portfolio Projects
The default Freelancer theme only supports client, date, application, and description fields for portfolio projects. I added a section to show languages, tools, concepts, & stack used for each project. They show up as tags.

![Screenshot of tags feature and markdown](/img/readme/tags.png)

#### Cute Icons
Relevant [Font Awesome](https://fortawesome.github.io/Font-Awesome/) were added to each header, overriding the default "star" icons.

![Screenshot of added header icons](/img/readme/icons.png)

## How to use
 - Fork or clone this repo to your own with name: ```your-github-username.github.io```
 - Overwrite profile picture in `/img/profile.jpg`
 - Replace `you@email.com` in `_includes/contact_static.html` with your email address. Refer to [formspree](http://formspree.io/) for more information.
 - Create new posts to display your projects & blog posts. See existing examples in ```_posts/blog/``` and ```_posts/portfolio/```
 - Update resume in ```/resume/your-name-resume.pdf```, and update ```_includes/about.html``` to reflect your resume file's name.
 - Push changes on master branch to remote
 - Go to your-github-username.github.io

## Demo
View this jekyll theme in action at [billmartin.io](http://billmartin.io)
