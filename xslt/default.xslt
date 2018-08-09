<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <!-- Make speak the root element -->
    <xsl:template match="body">
        <speak>
          <xsl:apply-templates select="node()|@*"/>
        </speak>
    </xsl:template>

    <!-- Copy these nodes over as is -->
    <xsl:template match="p">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <!-- Headings 1-2 -->
    <xsl:template match="h1|h2">
        <break strength="x-strong"/>
        <emphasis level="strong"><xsl:value-of select="."/></emphasis>
        <break strength="x-strong"/>
    </xsl:template>

    <!-- Headings 3-5 -->
    <xsl:template match="h3|h4|h5">
        <break strength="strong"/>
        <emphasis level="moderate"><xsl:value-of select="."/></emphasis>
        <break strength="strong"/>
    </xsl:template>

    <!-- Emphasis -->
    <xsl:template match="em|i">
        <emphasis level="moderate"><xsl:value-of select="."/></emphasis>
    </xsl:template>

    <!-- Strong -->
    <xsl:template match="strong|b">
        <emphasis level="strong"><xsl:value-of select="."/></emphasis>
    </xsl:template>

    <!-- Block quotes -->
    <xsl:template match="blockquote">
        <break strength="strong"/>
        <emphasis level="strong"><xsl:value-of select="."/></emphasis>
        <break strength="strong"/>
    </xsl:template>

    <!-- Inline quotes -->
    <xsl:template match="span[@class='quote']">
        <emphasis level="moderate"><xsl:value-of select="."/></emphasis>
    </xsl:template>
</xsl:stylesheet>
