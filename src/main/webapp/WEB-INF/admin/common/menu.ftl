

<#list leftMenu as root>
<li>
    <a href="#">
        <i class="fa fa-home"></i>
        <span class="nav-label">${root.menuName!}</span> <span class="fa arrow">
	  </span>
    </a>

    <ul class="nav nav-second-level">
     <#list  root.children as child>

        <li>
            <a class="J_menuItem" href="${ctx }${child.actionName!}" data-index="7">${child.menuName!}</a>
        </li>

      </#list>
    </ul>
</li>
</#list>
