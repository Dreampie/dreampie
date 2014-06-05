<#assign depth = 1 />
<#macro treenav nodes attrs>
  <#if nodes?? && nodes?size gt 0>
  <ul class="nav">
    <#list nodes as node>
      <li <#if depth==1>class="active"</#if>>

        <a style="padding-left: ${15*depth}px" nodeid="${node.id}" href="#nav_${node.id}"<#if attrs??><#list attrs?split(",") as attr>${attr}="${(node[attr])!}"</#list></#if>>
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