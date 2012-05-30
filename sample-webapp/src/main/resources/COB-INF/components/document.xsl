<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://xsltsl.org/string"
                xmlns:hct="http://forge.onehippo.org/gf/project/hct/1.0"
                version="1.0">

  <xsl:import href="../common/identity.xsl"/>
  <xsl:import href="../common/xsltsl-1.2.1/string.xsl"/>

  <xsl:output method="xml"/>
        
  <xsl:param name="contextPath"/>
  <xsl:param name="availability"/>
  <xsl:param name="locale"/>
    
  <xsl:template match="hct:document">
    <div id="{@name}">
      <div id="name">
        <xsl:value-of select="@localizedName"/>
      </div>
      <div id="type">
        <xsl:value-of select="@type"/>
      </div>
      <div id="pdf">
        <a>
          <xsl:attribute name="href">
            <xsl:call-template name="str:substring-before-last">
              <xsl:with-param name="text"
                              select="concat($contextPath, '/', $availability, '/',
                                             substring-after(substring-after(substring-after(@path, '/'), '/'), '/'))"/>
              <xsl:with-param name="chars">/</xsl:with-param>
            </xsl:call-template>
            <xsl:text>.pdf?lang=</xsl:text>
            <xsl:value-of select="$locale"/>
          </xsl:attribute>
          <xsl:text>PDF</xsl:text>
        </a>  
      </div>
      <xsl:apply-templates select="child::*"/>
    </div>    
  </xsl:template>

  <xsl:template match="hct:translations">
    <div id="translations">
      <ul>
        <xsl:for-each select="hct:translation">
          <li>
            <a>
              <xsl:attribute name="href">
                <xsl:call-template name="str:substring-before-last">
                  <xsl:with-param name="text"
                                  select="concat($contextPath, '/', $availability, '/',
                                                 substring-after(substring-after(substring-after(@path, '/'), '/'), '/'))"/>
                  <xsl:with-param name="chars">/</xsl:with-param>
                </xsl:call-template>
                <xsl:text>.html?lang=</xsl:text>
                <xsl:value-of select="@locale"/>
              </xsl:attribute>
              <xsl:value-of select="@localizedName"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>    
    </div>
  </xsl:template>

  <xsl:template match="hct:tags">
    <div id="tags">
      <ul>
        <xsl:for-each select="hct:tag">
          <li>
            <xsl:value-of select="text()"/>
          </li>
        </xsl:for-each>
      </ul>
    </div>
  </xsl:template>
  
  <xsl:template match="hct:taxonomies">
    <div id="taxonomies">
      <ul>
        <xsl:for-each select="hct:taxonomy">
          <li>
            <a href="{concat($contextPath, '/', $availability, '/', 'taxonomy', '/',
                      substring-after(substring-after(substring-after(substring-after(substring-after(@path, '/'), '/'), '/'), '/'), '/'), '/')}">
              <xsl:value-of select="@localizedName"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>
    </div>
  </xsl:template>

  <xsl:template match="hct:field">
    <div id="{@name}">
      <xsl:choose>
        <xsl:when test="not(html)">
          <xsl:for-each select="hct:value">
            <span>
              <xsl:value-of select="text()"/>
            </span>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="html/body/*"/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
    
  <xsl:template match="img">
    <xsl:variable name="embeddedPath" select="substring-before(@src, '/{_document}')"/>
    <img>
      <xsl:apply-templates select="@*[name() != 'src']"/>
      <xsl:attribute name="src">
        <xsl:call-template name="str:substring-before-last">
          <xsl:with-param name="text"
                          select="concat($contextPath, '/', substring-after(substring-after(
                                            ancestor::hct:field/hct:links/hct:link[$embeddedPath = @name]/@path, '/'), '/'))"/>
          <xsl:with-param name="chars">/</xsl:with-param>
        </xsl:call-template>
      </xsl:attribute>
    </img>
  </xsl:template>
    
  <xsl:template match="a">
    <a>
      <xsl:apply-templates select="@*[name() != 'href']"/>
      <xsl:choose>
        <xsl:when test="starts-with(@href, 'http') or starts-with(@href, 'mailto')">
          <xsl:apply-templates select="@href"/>        
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="name" select="@href"/>

          <xsl:attribute name="href">
            <xsl:choose>
              <xsl:when test="string-length(ancestor::hct:field/hct:links/hct:link[@name = $name]/@localizedName) &gt; 0">
                <xsl:variable name="docHref">
                  <xsl:call-template name="str:substring-before-last">
                    <xsl:with-param name="text"
                                    select="substring-after(substring-after(substring-after(ancestor::hct:field/hct:links/hct:link[@name = $name]/@path, '/'), '/'), '/')"/>
                    <xsl:with-param name="chars">/</xsl:with-param>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:value-of select="$contextPath"/>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$availability"/>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$docHref"/>
                <xsl:text>.html</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$contextPath"/>
                <xsl:text>/assets</xsl:text>
                <xsl:value-of select="ancestor::hct:field/hct:links/hct:link[@name = $name]/@path"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
    
  <xsl:template match="hct:images">
    <div id="images">
      <xsl:for-each select="hct:image">
        <div>
          <xsl:variable name="imgURL">
            <xsl:call-template name="str:substring-before-last">
              <xsl:with-param name="text" 
                              select="substring-after(substring-after(@path, '/'), '/')"/>
              <xsl:with-param name="chars">/</xsl:with-param>
            </xsl:call-template>
          </xsl:variable>
          <img src="{$contextPath}/{$imgURL}" alt="{@name}" height="{@height}" width="{@width}"/>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="hct:assets">
    <div id="assets">
      <xsl:for-each select="hct:asset">
        <div>
          <a href="{$contextPath}/assets{@path}" alt="{@name}">
            <xsl:value-of select="@name"/>
          </a>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>
    
  <xsl:template match="hct:relatedDocs">
    <div id="related">
      <xsl:for-each select="hct:document">
        <div>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="$contextPath"/>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="$availability"/>
              <xsl:text>/</xsl:text>
              <xsl:call-template name="str:substring-before-last">
                <xsl:with-param name="text"
                                select="substring-after(substring-after(substring-after(@path, '/'), '/'), '/')"/>
                <xsl:with-param name="chars">/</xsl:with-param>
              </xsl:call-template>
              <xsl:text>.html</xsl:text>
            </xsl:attribute>
                                
            <xsl:value-of select="@localizedName"/>
          </a>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

</xsl:stylesheet>
