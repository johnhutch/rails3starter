module PostsHelper

    def published?(post)
        if post.published
           %Q|published on #{post.published_at.stamp('Jan 1st 1999')}| 
        else
            "currently unpublished"
        end
    end

end
