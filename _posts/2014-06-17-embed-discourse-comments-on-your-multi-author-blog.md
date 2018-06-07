---
title: Embed Discourse Comments on Your Multi-Author Blog
date: 2014-06-17 06:10 UTC
tags: discourse
---

Discourse now allows embedding comments on multi-author blogs. Previously one
discourse username was used to create all blog article topics created by
Discourse. This approach works well for single author blogs but not so well for
multi-author ones. Since, topics are not created using the discourse username
of the author, new comment author notifications are not automatically sent
out.

This led me to write the [recently merged Discourse feature](https://github.com/discourse/discourse/pull/2428) that allows you to specify
the author's discourse username for each article published on a multi-author
blog.

Discourse has two methods for creating topics for blog posts

  1. RSS or Atom feed
  2. Readability algorithm

When any forum users comment on the blog article forum topic the comment will
appear on the blog as well.

## Configure embedding

1. Install Discourse. It is preferred that you use [discourse_docker](https://github.com/discourse/discourse_docker).
2. Navigate to *Embedding Site Settings*
   http://discourse.yourdomain.com/<b>admin/site_settings/category/embedding</b>
3. Configure the settings being sure to specify the following
  ![]({{ "/assets/img/discourse_embedding.png" | absolute_url }})
4. In your blog template include the following JavaScript snippet and `<div>` tag where you would like comments to appear.
    ```html
    <div id="discourse-comments"></div>

    <script type="text/javascript">
      var discourseUrl = 'http://blog.com/',
          discourseUserName = 'justin_leveck',
          discourseEmbedUrl = 'http://blog.com/2014/06/02/hello-world.html';

      (function() {
        var d = document.createElement('script'); d.type = 'text/javascript'; d.async = true; d.src = discourseUrl + 'javascripts/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(d);
      })();
    </script>
    ```
    **Caveats**

    1. Set `discourseUrl` so that it points to the root URL of your Discourse forum.
     2. Set `discourseUserName` to author's discourse username.
    3. Set `discourseEmbedUrl` to the canonical URL of the page where you are embedding Discourse. This URL must be unique otherwise multiple topics for the same article will be created.
5. Reload your blog to allow changes to take effect. Discourse will begin
   creating topics for your blog posts in your forum and comments should now
   be visible on your blog.
