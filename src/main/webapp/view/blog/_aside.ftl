<!-- 最热文章模块-->
<div class="panel hot">
    <div class="panel-heading">
        <i class="fa fa-fire"></i> 最热文章
        <i class="fa fa-times-circle panel-remove"></i>
        <i class="fa fa-chevron-circle-up panel-toggle"></i>
    </div>
    <!-- 大屏PC端-->
<#if hots?? && hots?size gt 0>
    <ul class="list-group list-group-flush visible-lg">
        <#list hots as hot>
            <li class="list-group-item"><a href="/blog/detail/${hot.id}" rel="bookmark" title="${hot.title}">
                <#if hot.title?? && hot.title?length gt 16>
                ${hot.title?substring(0,16)}
                    ...
                <#else>
                ${hot.title}
                </#if>
            </a><span
                    class="badge">${hot.hit_count}</span></li>
        </#list>
    </ul>
    <!-- 小屏PC端-->

    <ul class="list-group list-group-flush visible-md">
        <#list hots as hot>
            <li class="list-group-item"><a href="/blog/detail/${hot.id}" rel="bookmark" title="${hot.title}">
                <#if hot.title?? && hot.title?length gt 16>
                ${hot.title?substring(0,16)}
                    ...
                <#else>
                ${hot.title}
                </#if>
            </a><span
                    class="badge">${hot.hit_count}</span></li>
        </#list>
    </ul>
    <!-- 平板端 -->
    <ul class="list-group list-group-flush visible-sm">
        <#list hots as hot>
            <li class="list-group-item"><a href="/blog/detail/${hot.id}" rel="bookmark" title="${hot.title}">
                <#if hot.title?? && hot.title?length gt 16>
                ${hot.title?substring(0,16)}
                    ...
                <#else>
                ${hot.title}
                </#if>
            </a><span
                    class="badge">${hot.hit_count}</span></li>
        </#list>
    </ul>
    <!-- 手机端  -->
    <ul class="list-group list-group-flush visible-xs">
        <#list hots as hot>
            <li class="list-group-item"><a href="/blog/detail/${hot.id}" rel="bookmark" title="${hot.title}">
                <#if hot.title?? && hot.title?length gt 16>
                ${hot.title?substring(0,16)}
                    ...
                <#else>
                ${hot.title}
                </#if>
            </a><span
                    class="badge">${hot.hit_count}</span></li>
        </#list>
    </ul>

</#if>
</div>
<!-- 最新评论模块 -->
<div class="visible-md visible-lg">
    <div class="panel panel-zan">
        <div class="panel-heading">
            <i class="fa fa-comments"></i> 最新评论
            <i class="fa fa-times-circle panel-remove"></i>
            <i class="fa fa-chevron-circle-up panel-toggle"></i>
        </div>
        <!-- 大屏PC端 -->
        <ul class="list-group list-group-flush visible-lg">
            <li class="list-group-item"><img alt="" src="http://www.gravatar.com/avatar/?d=monsterid&amp;s=40"
                                             class="avatar avatar-40 photo avatar-default" height="40" width="40"><span class="comment-log"> <a
                    href="http://www.yeahzan.com/zanblog/message#ds-thread" title="on 问题反馈">顶部导航的2级菜单，比如你这个相关技术，...&nbsp;</a></span></li>
            <li class="list-group-item"><img alt=""
                                             src="http://www.gravatar.com/avatar/544a22e050f7927cd721b37c487e63b0?s=40&amp;d=monsterid&amp;r=G"
                                             class="avatar avatar-40 photo" height="40" width="40"><span class="comment-log"> <a
                    href="http://www.yeahzan.com/zanblog/message#ds-thread" title="on 问题反馈">3.0版本想让手机显示搜索，但是手机访问...&nbsp;</a></span></li>
            <li class="list-group-item"><img alt="" src="http://www.gravatar.com/avatar/?d=monsterid&amp;s=40"
                                             class="avatar avatar-40 photo avatar-default" height="40" width="40"><span class="comment-log"> <a
                    href="http://www.yeahzan.com/zanblog/message#ds-thread" title="on 问题反馈">zanblog3替换logo，为什么我用...&nbsp;</a></span></li>
            <li class="list-group-item"><img alt=""
                                             src="http://www.gravatar.com/avatar/5e565f28be4737513bb98ee094d611ba?s=40&amp;d=monsterid&amp;r=G"
                                             class="avatar avatar-40 photo" height="40" width="40"><span class="comment-log"> <a
                    href="http://www.yeahzan.com/zanblog/archives/843.html#ds-thread" title="on ZanBlog3.0.0 正式发布！">什么时候可以下载！！期待&nbsp;</a></span>
            </li>
            <li class="list-group-item"><img alt=""
                                             src="http://www.gravatar.com/avatar/f38e528f6bf25d83f56bb74bab46a640?s=40&amp;d=monsterid&amp;r=G"
                                             class="avatar avatar-40 photo" height="40" width="40"><span class="comment-log"> <a
                    href="http://www.yeahzan.com/zanblog/archives/843.html#ds-thread" title="on ZanBlog3.0.0 正式发布！">很好看~&nbsp;</a></span></li>
            <li class="list-group-item"><img alt=""
                                             src="http://www.gravatar.com/avatar/8653544e3c87ad98605dd8c0059fcfc1?s=40&amp;d=monsterid&amp;r=G"
                                             class="avatar avatar-40 photo" height="40" width="40"><span class="comment-log"> <a
                    href="http://www.yeahzan.com/zanblog/archives/843.html#ds-thread" title="on ZanBlog3.0.0 正式发布！">终于来了！！&nbsp;</a></span></li>
        </ul>
        <!-- 小屏PC端 -->
        <ul class="list-group list-group-flush visible-md">
            <li class="list-group-item"><img alt="" src="http://www.gravatar.com/avatar/?d=monsterid&amp;s=40"
                                             class="avatar avatar-40 photo avatar-default" height="40" width="40"><span class="comment-log"> <a
                    href="http://www.yeahzan.com/zanblog/message#ds-thread" title="on 问题反馈">顶部导航的2级菜单，比如你这个...&nbsp;</a></span></li>
            <li class="list-group-item"><img alt=""
                                             src="http://www.gravatar.com/avatar/544a22e050f7927cd721b37c487e63b0?s=40&amp;d=monsterid&amp;r=G"
                                             class="avatar avatar-40 photo" height="40" width="40"><span class="comment-log"> <a
                    href="http://www.yeahzan.com/zanblog/message#ds-thread" title="on 问题反馈">3.0版本想让手机显示搜索，但...&nbsp;</a></span></li>
            <li class="list-group-item"><img alt="" src="http://www.gravatar.com/avatar/?d=monsterid&amp;s=40"
                                             class="avatar avatar-40 photo avatar-default" height="40" width="40"><span class="comment-log"> <a
                    href="http://www.yeahzan.com/zanblog/message#ds-thread" title="on 问题反馈">zanblog3替换logo，...&nbsp;</a></span></li>
            <li class="list-group-item"><img alt=""
                                             src="http://www.gravatar.com/avatar/5e565f28be4737513bb98ee094d611ba?s=40&amp;d=monsterid&amp;r=G"
                                             class="avatar avatar-40 photo" height="40" width="40"><span class="comment-log"> <a
                    href="http://www.yeahzan.com/zanblog/archives/843.html#ds-thread" title="on ZanBlog3.0.0 正式发布！">什么时候可以下载！！期待&nbsp;</a></span>
            </li>
            <li class="list-group-item"><img alt=""
                                             src="http://www.gravatar.com/avatar/f38e528f6bf25d83f56bb74bab46a640?s=40&amp;d=monsterid&amp;r=G"
                                             class="avatar avatar-40 photo" height="40" width="40"><span class="comment-log"> <a
                    href="http://www.yeahzan.com/zanblog/archives/843.html#ds-thread" title="on ZanBlog3.0.0 正式发布！">很好看~&nbsp;</a></span></li>
            <li class="list-group-item"><img alt=""
                                             src="http://www.gravatar.com/avatar/8653544e3c87ad98605dd8c0059fcfc1?s=40&amp;d=monsterid&amp;r=G"
                                             class="avatar avatar-40 photo" height="40" width="40"><span class="comment-log"> <a
                    href="http://www.yeahzan.com/zanblog/archives/843.html#ds-thread" title="on ZanBlog3.0.0 正式发布！">终于来了！！&nbsp;</a></span></li>
        </ul>
    </div>
</div>
<!-- 最新文章模块 -->
<div class=" visible-md visible-lg">
    <div class="panel recent">
        <div class="panel-heading">
            <i class="fa fa-refresh"></i> 最新文章
            <i class="fa fa-times-circle panel-remove"></i>
            <i class="fa fa-chevron-circle-up panel-toggle"></i>
        </div>
        <!-- 大屏PC端-->
    <#if tops?? && tops?size gt 0>
        <ul class="list-group list-group-flush visible-lg">
            <#list tops as top>
                <li class="list-group-item"><a href="/blog/detail/${top.id}" rel="bookmark" title="${top.title}">${top.title}</a><span
                        class="badge">${top.hit_count}</span></li>
            </#list>
        </ul>
        <!-- 小屏PC端-->

        <ul class="list-group list-group-flush visible-md">
            <#list tops as top>
                <li class="list-group-item"><a href="/blog/detail/${top.id}" rel="bookmark" title="${top.title}">${top.title}</a><span
                        class="badge">${top.hit_count}</span></li>
            </#list>
        </ul>
        <!-- 平板端 -->
        <ul class="list-group list-group-flush visible-sm">
            <#list tops as top>
                <li class="list-group-item"><a href="/blog/detail/${top.id}" rel="bookmark" title="${top.title}">${top.title}</a><span
                        class="badge">${top.hit_count}</span></li>
            </#list>
        </ul>
        <!-- 手机端  -->
        <ul class="list-group list-group-flush visible-xs">
            <#list tops as top>
                <li class="list-group-item"><a href="/blog/detail/${top.id}" rel="bookmark" title="${top.title}">${top.title}</a><span
                        class="badge">${top.hit_count}</span></li>
            </#list>
        </ul>

    </#if>
    </div>
</div>
<!-- 分类目录、热门标签、友情链接模块-->
<div class="panel hidden-xs">
    <ul class="nav nav-pills pills-zan">
        <li class="active"><a href="#sidebar-categories" data-toggle="tab">分类目录</a></li>
        <li><a href="#sidebar-tags" data-toggle="tab">热门标签</a></li>
        <li><a href="#sidebar-links" data-toggle="tab">友情链接</a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active nav bs-sidenav fade in" id="sidebar-categories">
            <li class="cat-item cat-item-21"><a href="http://www.yeahzan.com/zanblog/archives/category/bootstrap" title="查看Bootstrap3下的所有文章">Bootstrap3</a>
            </li>
            <li class="cat-item cat-item-17"><a href="http://www.yeahzan.com/zanblog/archives/category/wordpress"
                                                title="查看WordPress下的所有文章">WordPress</a>
            </li>
            <li class="cat-item cat-item-29"><a href="http://www.yeahzan.com/zanblog/archives/category/zanblog"
                                                title="查看Zanblog下的所有文章">Zanblog</a>
            </li>
        </div>
        <div class="tab-pane fade" id="sidebar-tags"><a href="http://www.yeahzan.com/zanblog/archives/tag/bootstrap" class="tag-link-21"
                                                        title="2个话题" style="color:#5a6e43;font-size: 11pt;;">Bootstrap3</a>
            <a href="http://www.yeahzan.com/zanblog/archives/tag/wordpress%e4%b8%bb%e9%a2%98" class="tag-link-22" title="4个话题"
               style="color:#7064f4;font-size: 14.666666666667pt;;">WordPress</a>
            <a href="http://www.yeahzan.com/zanblog/archives/tag/zanblog" class="tag-link-29" title="17个话题"
               style="color:#1966fb;font-size: 24pt;;">Zanblog</a>
            <a href="http://www.yeahzan.com/zanblog/archives/tag/zanui" class="tag-link-32" title="1个话题"
               style="color:#fe94c;font-size: 8pt;;">ZanUI</a>
        </div>
        <div class="tab-pane nav bs-sidenav fade" id="sidebar-links">
            <li><a href="http://www.yeahzan.com/" title="杭州网站建设" target="_blank">佚站互联</a></li>
            <li><a href="http://www.yeahzan.com/" title="杭州网站建设">杭州网站建设</a></li>
        </div>
    </div>
</div>
<!-- 文章存档模块	 -->
<div class="panel visible-md visible-lg archive">
    <a href="http://www.yeahzan.com/zanblog/archive">
        <div class="panel-heading">
            <i class="fa fa-folder-open"></i> <span>文章存档</span>
        </div>
    </a>
</div>


<script type="text/javascript">
    require(['../../javascript/app'], function () {
        require(['jquery'], function () {
            /**
             * Sidebar panel toggle.
             */

            var toggleBtn = $('.panel-toggle');

            toggleBtn.data('toggle', true);

            toggleBtn.click(function () {

                var btn = $(this);

                if (btn.data('toggle')) {

                    btn.removeClass('fa-chevron-circle-up').addClass('fa-chevron-circle-down');
//                    btn.parents('div.panel').find("ul.list-group").slideUp();
                    btn.parents('div.panel').addClass('toggled');
                    btn.data('toggle', false);
                } else {

                    btn.removeClass('fa-chevron-circle-down').addClass('fa-chevron-circle-up');
//                    btn.parents('div.panel').find("ul.list-group").slideDown();
                    btn.parents('div.panel').removeClass('toggled');
                    btn.data('toggle', true);
                }

            });

            /**
             * Sidebar panel close.
             */

            var closeBtn = $('.panel-remove');

            closeBtn.click(function () {

                var btn = $(this);

                btn.parents('.panel').toggle(300);

            });
        });
    });
</script>