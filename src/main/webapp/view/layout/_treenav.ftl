<#assign depth = 1 />
<#macro treenav nodes attrs>
    <#if nodes?? && nodes?size gt 0>
    <ul class="nav <#if depth gt 3>hide</#if>">
        <#list nodes as node>
            <li class="<#if depth==1>active</#if>">
                <a  nodeid="${node.id}"
                   href="#nav_${node.id}"<#if attrs??><#list attrs?split(",") as attr>${attr}="${(node[attr])!}
                "</#list></#if>><i style="padding-left: ${15*depth}px;width: ${(30+14*(depth-1))}px;"
                  class="glyphicon <#if depth==1 || !node.children?? || (node.children?? && node.children?size lte 0)> glyphicon-minus-sign<#else>glyphicon-plus-sign</#if>"></i>
            ${(node.name)!}
                </a>
                <#assign depth = depth + 1 />
                <@treenav nodes=node.children attrs=attrs/>
                <#assign depth = depth - 1 />
            </li>
        </#list>
    </ul>
    </#if>
</#macro>