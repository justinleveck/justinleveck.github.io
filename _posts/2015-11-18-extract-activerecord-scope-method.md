---
title: Extract ActiveRecord Scope Method
date: 2015-11-18 20:05 UTC
tags: rails, extract method, refactoring
---

Peer review today lead to a great refactoring opportunity. The pull request
centered around allowing signed in site administrators to view unpublished blog
posts.

**Original**

My goal here is to only have the `published` scope apply if the `current_user`
is not an administrator in both the `index` and `blog_post` actions.

```ruby
class BlogController < SiteController

  def index
    @blog_posts = blog.blog_posts.published
  end

  def blog_post
    @blog_post = blog.blog_posts.published.friendly.find(params[:id])
  end

  private

  def blog
    current_site.blog
  end
end
```

**Initial Attempt**

My first attempt is not very clean in the `blog_post` action.

- The intent is lost being spread across 3 lines
- The `current_user.try(:administrator?)` logic is duplicated across two
actions

```ruby
class BlogController < SiteController

  def index
    if current_user.try(:administrator?)
      @blog_posts = blog.blog_posts
    else
      @blog_posts = blog.blog_posts.published
    end
  end

  def blog_post
    blog_posts = blog.blog_posts
    blog_posts = blog_posts.published unless current_user.try(:administrator?)
    @blog_post = blog_posts.friendly.find(params[:id])
  end

  private

  def blog
    current_site.blog
  end
end

```

**Refactor**

And now for the refactor. Here you can see how this really cleaned up. 

The `ActiveRecord` scope has been extracted to a private method named
`blog_posts_scope`

This extracted scope can now be used in the `index` and `blog_post` actions and
it gets rid of the logic duplication to determine if the `current_user` is an
administrator.


```ruby
class BlogController < SiteController

  def index
    @blog_posts = blog_posts_scope
  end

  def blog_post
    @blog_post = blog_posts_scope.friendly.find(params[:id])
  end

  private

  def blog_posts_scope
    if current_user.try(:administrator?)
      blog.blog_posts
    else
      blog.blog_posts.published
    end
  end

  def blog
    current_site.blog
  end
end
```

Peer reviews and refactoring techniques for the win!
