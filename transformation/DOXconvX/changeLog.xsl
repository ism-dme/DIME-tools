<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>
				<b>2.4.0</b> (21.07.2020)<ul>
					<li>Delete modules countMeasures and create-IDs</li>
					<li>Bugfix: If &lt;staffDef&gt; does not have @dme.parts, original attributes are preserved.</li>
					<li>For the mode <b>deleteAttributes</b>: <ul>
							<li>restrict @position to staff/@position</li>
							<li>expand dynam/@subtype to @subtype</li>
							<li>add <ul>
									<li>@mm</li>
									<li>@enclose</li>
									<li>note/@layer[contains(., '1 2')]</li>
									<li>@right[. = 'rptboth']</li>
									<li>@type[. = ('enclose', 'upbeat', 'Verlagsnummer', 'bartext', 'ce')]</li>
								</ul>
							</li>
						<li>Change naming convention for the comparion files</li>
						</ul>
					</li>
					<li>Internal: <ul>
							<li>Delete <i>xd:</i>- and <i>xsl:</i>-prefixes where possible</li>
							<li>Delete the folder <i>external</i></li>
						</ul>
					</li>
				</ul>
			</p>
			<p>
				<b>2.3.13</b> (25.03.2020) <ul>
					<li>&lt;staffDef&gt;/@label.abbr is added for genre='orchestral' only</li>
					<li>&lt;label&gt;. The value is taken from one of the sources in the following precedence order (previously, from @label only): <ul>
							<li>&lt;label&gt;</li>
							<li>@label</li>
							<li>Instrument name which is referenced form the respective &lt;perfRes&gt;/@codedval</li>
						</ul>
					</li>
					<li>Deprecate <b>genres</b></li>
					<li>internal changes: <ul>
							<li>Move the deletion of @dme.parts to the deleteAttributes.xsl</li>
							<li>Move the adding of &lt;scoreDef&gt;/@optimize='false' to the scoreDef.xsl</li>
						</ul>
					</li>
				</ul>
			</p>
			<p>
				<b>2.3.12</b> (24.03.2020) <ul>
					<li>Extract <i>unsupplied-dir_@num-visible.xsl</i> for use as separate scenario</li>
					<li>&lt;application&gt;<ul>
							<li>add left and right trim for the first and last text nodes respectively</li>
							<li>&lt;persName&gt;[@xml:id="JoKep"]: add <ul>
									<li><i>@authURI</i>='https://d-nb.info/gnd/174032757'</li>
									<li><i>@authority</i>='GND'</li>
									<li><i>@codedval</i>='174032757'</li>
								</ul></li>
							<li>&lt;persName&gt;[@xml:id="FKel"]: replace @<i>xml:id</i>='FKel' => @<i>analog</i>='#FK'</li>
							<li>&lt;ref&gt; for 'mozarteum.at': replace text to <i>Salzburg Mozarteum Foundation</i></li>
							<li>&lt;ref&gt; for 'edirom.de':<ul>
									<li> add 'https' for <i>@target</i>
									</li>
									<li>add &lt;corpName&gt; with following attributes: <ul>
											<li><i>@authURI</i>='https://d-nb.info/gnd/1095564986'</li>
											<li><i>@authority</i>='GND'</li>
											<li><i>@codedval</i>='1095564986'</li>
											<li>text: 'ViFE'</li>
										</ul></li>
								</ul>
							</li>
						</ul>
					</li>
					<li>&lt;revisionDesc&gt;<ul>
							<li>Replace value for <i>@resp</i>: '#FKel' => '#FK'</li>
						</ul></li>
				</ul>
			</p>
			<p>
				<b>2.3.11</b> (20.03.2020) <ul>
					<li>read &lt;key&gt; attributes from ISM-database and add them to &lt;workDesc&gt;/&lt;key&gt; and &lt;scoreDef&gt;</li>
					<li>reorganized modules for better comparison and more convenient development<ul>
							<li>added module <i>scoreDef</i> (extracted from <i>DcX_1</i>)</li>
							<li>moved create-IDs to another place in the transformation chain as it caused problems for other stylesheets</li>
							<li>added <i>checkAccidentalsVisibility</i></li>
							<li>added modules <i>deleteAttributes</i> and <i>unsupplied-dir_@num-visible</i> (extracted from <i>DcX_2</i>)</li>
						</ul>
					</li>
				</ul>
			</p>
			<p>
				<b>2.3.10</b> (13.03.2020) <ul>
					<li>#bugfix: options for create-IDs were not available</li>
				</ul>
			</p>
			<p>
				<b>2.3.9</b> (12.03.2020) <ul>
					<li>Remove the mode <i>checkAccidentals</i></li>
				</ul>
			</p>
			<p>
				<b>2.2.8</b> (11.03.2020) <ul>
					<li>&lt;appInfo&gt; and &lt;revisionDesc&gt; from the original file are preserved</li>
					<li>&lt;perfResList&gt;: add @analog, @authority</li>
					<li>&lt;perfRes&gt;: del @authority</li>
					<li>&lt;soreDef&gt;: for "orchestral", "chamber" add @optimize="false"</li>
					<li>rename mode 'string quartet' >> 'chamber'. When chamber: del @label.abbr</li>
					<li>changed the input of the processed document</li>
					<li>add changeLog</li>
				</ul>
			</p>
			<p>
				<ul>
					<li>06.03.2020: <i>2.2.7</i></li>
					<li>07.11.2019: <i>2.2.6</i></li>
					<li>17.09.2019: <i>2.2.5</i></li>
					<li>14.08.2019: <i>2.2.4</i></li>
					<li>23.07.2019: <i>2.2.3</i></li>
					<li>19.06.2019: <i>2.2.2</i></li>
					<li>04.06.2019: <i>2.2.1</i></li>
					<li>11.04.2019: <i>2.2.0</i></li>
					<li>26.03.2019: <i>2.1.1</i></li>
					<li>11.03.2019: <i>2.0.1</i></li>
					<li>25.03.2019: <i>2.1.0</i></li>
					<li>08.03.2019: <i>2.0.0</i></li>
					<li>20.11.2018: <i>1.1.0</i></li>
					<li>13.08.2018: <i>1.0.0</i></li>
				</ul>
			</p>
		</desc>
	</doc>

</xsl:stylesheet>
