This is the source code for my [Jekyll](https://jekyllrb.com/)-based portfolio at [billmartin.io](http://billmartin.io), which uses the [Freelancer Jekyll Theme](https://jeromelachaud.github.io/freelancer-theme) with my own additions.

## My Additions
### Resume Linking
The "Download Resume" button was added on the about page to allow resume downloading after reading about how awesome you are.
[screenshot] 

### Allow Blog Posts
In addition to the default portfolio posts, I added the ability to also make blog posts. The new folder structure is:

[screenshot of structure]
[screenshot of blogs]

### Support Tags on Portfolio Projects
The default Freelancer theme only supports client, date, application, and description fields for portfolio projects. I added a footer section to allow languages, tools, concepts, & stack used. They show up as tags.

[screenshot of config]
[screenshot of tags feature]

### Cute Icons
Relevant [Font Awesome](https://fortawesome.github.io/Font-Awesome/) were added to each header, overriding the default "star" icons used everywhere.

[screenshot]

## How to use
 - Overwrite profile picture in `/img/profile.jpg`
 - Replace `you@email.com` in `_includes/contact_static.html` with your email address. Refer to [formspree](http://formspree.io/) for more information.
 - Create new posts to display your projects & blog posts. See existing examples in ```_posts/blog/``` and ```_posts/portfolio/```
 - Update resume in ```/resume/your-name-resume.pdf```, and update ```_includes/about.html``` to reflect your resume file's name.

## Demo
View this jekyll theme in action at [billmartin.io](http://billmartin.io)
