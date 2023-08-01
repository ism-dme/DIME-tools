#!/usr/bin/env python
"""Reads data from /edition folder and creates Excel table with Dublin Core fields

SETTINGS:

   Following MEI versions are recognized: 3.x.x., 4.x.x

:author: sapov@mozarteum.at
"""
import sys
import os
from lxml import etree
import codecs
import pandas as pd
import glob2


class DublinCore:
    def __init__(self):
        self.ns = {'mei': 'http://www.music-encoding.org/ns/mei', 'xml': 'http://www.w3.org/XML/1998/namespace'}
        self.dc_items = ['fileName', 'meiVersion', 'identifiers', 'descriptions', 'titles', 'relations', 'creators',
                         'contributors',
                         'publishers',
                         'dates', 'formats', 'rights', 'sources']
        self.tree = None
        self.meiHead = None
        self.file_path = None
        self.fileName = None
        self.meiVersion = None
        self.NMA_editors = None
        self.NMA_editors_roles = None
        self.NMA1 = None
        self.NMA2 = None
        self.NMA3 = None
        self.KB = None
        self.sources = []
        self.data_list = None
        self.data = None

        # DC fields
        self.identifier = None
        self.description = None
        self.title = None
        self.relation = None
        self.creator = None
        self.encoder = None
        self.proofreader = None
        self.contributors = None
        self.publisher = None
        self.date = None
        self.format = None
        self.rights = None

    def initDC(self):
        try:
            self.tree = etree.parse(self.file_path)
            self.meiHead = self.tree.getroot()[0]
            self.meiVersion = self.meiHead.xpath('/mei:mei/@meiversion',
                                                 namespaces=self.ns)
            self.fetchHeaderData()
            # self.prepareData()
            # self.createFileNames()
            # print self.writeFile()
        except:
            pass

    def fetchHeaderData(self):

        self.identifier = self.meiHead.xpath('//mei:title[@xml:id="fd_tit_3"]/mei:ref/@target',
                                             namespaces=self.ns)
        self.description = self.meiHead.xpath('//mei:fileDesc/mei:notesStmt[1]/mei:annot[1]/text()',
                                              namespaces=self.ns)
        self.gettitle()
        self.getrelations()
        self.creator = self.meiHead.xpath('//mei:*[@xml:id="WAM"]/text()',
                                          namespaces=self.ns)
        self.NMA_editors = self.meiHead.xpath('//mei:corpName[@xml:id = "NMA-editors"]//mei:persName/text()',
                                              namespaces=self.ns)
        self.NMA_editors_roles = self.meiHead.xpath('//mei:corpName[@xml:id = "NMA-editors"]//mei:persName/@role',
                                                    namespaces=self.ns)

        counter = 0
        for i in self.NMA_editors:
            self.NMA_editors[counter] = self.NMA_editors[counter] + " (NMA: " + self.NMA_editors_roles[counter] + ")"
            counter += 1

        self.contributors = self.NMA_editors
        self.geteencoder()
        if self.encoder is not None:
            self.contributors.append(self.encoder)
        self.getproofreader()
        if self.proofreader is not None:
            self.contributors.append(self.proofreader)

        self.publisher = self.meiHead.xpath('//mei:corpName[@codedval="37019-8"]/text()',
                                            namespaces=self.ns)
        self.getdate()
        self.format = ['XML with MEI namespace']
        self.rights = self.meiHead.xpath('//mei:useRestrict[@label="license"]/text()',
                                         namespaces=self.ns)
        self.getsources()

    def gettitle(self):

        if self.meiVersion[0].startswith('3'):
            title_1 = self.meiHead.xpath(
                '//mei:workDesc/mei:work//mei:titleStmt//mei:title[@type = "main" and @xml:lang="EN"]/mei:title/text()',
                namespaces=self.ns)

            title_2 = self.meiHead.xpath(
                '//mei:workDesc/mei:work//mei:titleStmt//mei:title[@type = "main" and @xml:lang="EN"]/mei:identifier[@label="KV"]/text()',
                namespaces=self.ns)
        elif self.meiVersion[0].startswith('4'):
            title_1 = self.meiHead.xpath(
                '//mei:workList/mei:work[1]/mei:title[@type="main" and @xml:lang="EN"]/mei:titlePart[1]/text()',
                namespaces=self.ns)
            title_2 = self.meiHead.xpath(
                '//mei:workList/mei:work[1]/mei:title[@type="main" and @xml:lang="EN"]/mei:identifier[@label="KV"]/text()',
                namespaces=self.ns)

        else:
            print('meiVersion is not defined.')
        # test for indexError (if the list is empty) and strip
        title_1 = self.testindexerror(title_1)
        title_2 = self.testindexerror(title_2)
        # joing with comma (if not empty)
        concat = ", ".join(filter(None, [title_1, title_2]))
        # DC needs to have it in a list
        self.title = [concat]

    def getrelations(self):
        self.relation = []
        if self.meiVersion[0].startswith('3'):
            movementtext = self.meiHead.xpath(
                '//mei:work//mei:titleStmt//mei:title[@type="subordinate" and @xml:lang="EN"]/text()',
                namespaces=self.ns)
            tempo = self.meiHead.xpath(
                '//*[@xml:id="tempo"]/text()',
                namespaces=self.ns)
            movementKVonline = self.meiHead.xpath(
                '//mei:identifier[@type="movement" and @authority="KVonline"]/text()',
                namespaces=self.ns)
        elif self.meiVersion[0].startswith('4'):
            movementtext = self.meiHead.xpath(
                '//mei:workList/mei:work[1]/mei:title[@type="main" and @xml:lang="EN"]/mei:titlePart[@type="subordinate"]/text()',
                namespaces=self.ns)
            tempo = self.meiHead.xpath(
                '//*[@xml:id="tempo"]/text()',
                namespaces=self.ns)
            movementKVonline = self.meiHead.xpath(
                '//mei:workList[1]/mei:work[@label="individual movement"]/mei:identifier[@type="movement" and @auth="KVonline"]/text() ',
                namespaces=self.ns)
        else:
            print('meiVersion is not defined or not available.')

        # test if the list is empty, otherwise IndexError. TODO: Find better solution for extracting values
        movementtext = self.testindexerror(movementtext)
        tempo = self.testindexerror(tempo)
        movementKVonline = self.testindexerror(movementKVonline)

        movement = ", ".join(filter(None, [movementtext, tempo, movementKVonline]))
        project = self.meiHead.xpath('//mei:fileDesc/mei:seriesStmt/mei:title[1]/text()',
                                     namespaces=self.ns)
        project = self.testindexerror(project)

        self.relation.append(movement)
        self.relation.append(project)

    def geteencoder(self):
        if self.meiVersion[0].startswith('3'):
            encoder = self.meiHead.xpath('//mei:persName[@xml:id="ed.p1" ]/text()',
                                         namespaces=self.ns)
        elif self.meiVersion[0].startswith('4'):

            encoder = self.meiHead.xpath(
                '//mei:persName[@xml:id = substring-after(//mei:persName[@xml:id="ed.p1"]/@sameas, "#")]/text()',
                namespaces=self.ns)
        else:
            print('meiVersion is not defined or not available.')

        encoder = self.testindexerror(encoder)
        if not '' == encoder:
            self.encoder = encoder + " (DIME: encoder)"

    def getproofreader(self):
        if self.meiVersion[0].startswith('3'):
            proofreader = self.meiHead.xpath(
                '//mei:persName[@xml:id="pr.p1"]/text()',
                namespaces=self.ns)

        elif self.meiVersion[0].startswith('4'):

            proofreader = self.meiHead.xpath(
                '//mei:persName[@xml:id = substring-after(//mei:persName[@xml:id="pr.p1"]/@sameas, "#")]/text()',
                namespaces=self.ns)

        else:
            print('meiVersion is not defined or not available.')

        proofreader = self.testindexerror(proofreader)
        if not '' == proofreader:
            self.proofreader = proofreader + " (DIME: proofreader)"


    def getdate(self):
        if self.meiVersion[0].startswith('3'):
            self.date = self.meiHead.xpath('//mei:date[@type="release"]/@isodate',
                                           namespaces=self.ns)

        elif self.meiVersion[0].startswith('4'):
            self.date = self.meiHead.xpath('//mei:date[@label="first release"]/@isodate',
                                           namespaces=self.ns)
        else:
            print('meiVersion is not defined or not available.')

    def getsources(self):
        if self.meiVersion[0].startswith('3'):
            self.NMA1 = self.meiHead.xpath('//mei:source[@label="NMA1"]//mei:annot[@n="1"]',
                                           namespaces=self.ns)
            if len(self.NMA1) > 0:
                self.sources.append(self.NMA1[0].text)

            self.NMA2 = self.meiHead.xpath('//mei:source[@label="NMA2"]//mei:annot[@n="1"]',
                                           namespaces=self.ns)
            if len(self.NMA2) > 0:
                self.sources.append(self.NMA2[0].text)

            self.NMA3 = self.meiHead.xpath('//mei:source[@label="NMA3"]//mei:annot[@n="1"]',
                                           namespaces=self.ns)
            if len(self.NMA3) > 0:
                self.sources.append(self.NMA3[0].text)

            self.KB = self.meiHead.xpath('//mei:source[@label="NMA-KB"]//mei:annot[@n="1"]',
                                         namespaces=self.ns)
            if len(self.KB) > 0:
                self.sources.append(self.KB[0].text)

        elif self.meiVersion[0].startswith('4'):
            sources = self.meiHead.xpath(
                '//mei:source[(@label = "NMA1") or (@label = "NMA2") or (@label = "NMA3") or (@label = "NMA-KB")]',
                namespaces=self.ns)

            xslt_editor_name = etree.XML('''\
                                   <xsl:stylesheet version="1.0" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:param name="ref"/>

      <xsl:template match="/">
        <xsl:variable name="editorName" select=".//mei:persName[@xml:id = $ref]/text()"/>
        <editor>
          <xsl:value-of select="$editorName"/>
        </editor>
      </xsl:template>
    </xsl:stylesheet>''')
            get_editor_name = etree.XSLT(xslt_editor_name)

            xslt_sameas = etree.XML('''\
                                                <xsl:stylesheet version="1.0" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

      <xsl:template match="/">
        <references>
          <xsl:for-each select="//mei:editor[@corresp = '#NMA-editors']//mei:persName/@sameas">
            <ref>
              <xsl:value-of select="substring-after(., '#')"/>
            </ref>
          </xsl:for-each>
        </references>
      </xsl:template>
    </xsl:stylesheet>''')

            get_sameas = etree.XSLT(xslt_sameas)

            xslt_sameas_author = etree.XML('''\
                                                            <xsl:stylesheet version="1.0" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

                  <xsl:template match="/">
                    <references>
                      <xsl:for-each select="//mei:author/@sameas">
                        <ref>
                          <xsl:value-of select="substring-after(., '#')"/>
                        </ref>
                      </xsl:for-each>
                    </references>
                  </xsl:template>
                </xsl:stylesheet>''')

            get_sameas_author = etree.XSLT(xslt_sameas_author)

            for i in sources:
                KB = 'NMA-KB' in i.xpath('./@label', namespaces=self.ns)

                if (KB):
                    volume = i.xpath('.//mei:title/text()', namespaces=self.ns)
                else:
                    volume = i.xpath('.//mei:title[@type="volume"]/text()', namespaces=self.ns)
                volume = self.testindexerror(volume)

                if (KB):
                    refs = get_sameas_author(i)
                else:
                    refs = get_sameas(i)

                refs = refs.getroot().xpath('./ref/text()', namespaces=self.ns)

                for idx, val in enumerate(refs):
                    ref_value = etree.XSLT.strparam(val)
                    name = get_editor_name(self.meiHead, ref=ref_value)
                    refs[idx] = name.getroot().text
                editors = " und ".join(filter(None, refs))

                pubPlace = i.xpath('.//mei:pubPlace/text()', namespaces=self.ns)
                pubPlace = self.testindexerror(pubPlace)

                publisher = i.xpath('.//mei:identifier/@auth', namespaces=self.ns)
                publisher = self.testindexerror(publisher)

                date = i.xpath('.//mei:date/text()', namespaces=self.ns)
                date = self.testindexerror(date)

                pages = i.xpath('.//mei:biblScope[@unit="page"]/text()', namespaces=self.ns)
                pages = self.testindexerror(pages)

                if (KB):
                    source = volume + ' Vorgelegt von ' + editors + '. ' + pubPlace + ': ' + publisher + ', ' + date + '.'
                else:
                    source = volume + '. Ed. ' + editors + '. ' + pubPlace + ': ' + publisher + ', ' + date + ', p. ' + pages + '.'

                self.sources.append(source)



        else:
            print('meiVersion is not defined or not available.')

    def testindexerror(self, list):
        if len(list) > 0:
            list = list[0].strip()
        else:
            list = ''
        return list


def getdata(filepaths):
    data = []
    for file_path in filepaths:
        filename = file_path.split('\\')[-1]
        current_k = filename.split('_')[1].split('-')[0]
        redundant_files = ['034', '049', '282', '320', '365', '425', '457', '492']
        if current_k not in redundant_files:
            dc = DublinCore()
            dc.file_path = file_path
            dc.fileName = filename
            dc.initDC()
            data_list = [dc.fileName, dc.meiVersion, dc.identifier, dc.description, dc.title, dc.relation, dc.creator,
                         dc.contributors, dc.publisher, dc.date, dc.format, dc.rights, dc.sources]
            data_dict = dict(list((zip(dc.dc_items, data_list))))
            data.append(data_dict)
    return data


def insertcolumn(col_name, position):
    col_name = col_name
    first_col = df.pop(col_name)
    df.insert(position, col_name, first_col)


if __name__ == "__main__":
    # folderpath = r"C:\Users\sapov\DIME\dime-repo_working-set\trunk\edition\332_4105"
    folderpath = r"C:\Users\sapov\DIME\dime-repo_working-set\trunk\edition"
    filepaths = glob2.glob(
        os.path.join(folderpath, '**', 'dmeref_[0-9][0-9][0-9]-[0-9][0-9][0-9]_[0-9][0-9][0-9][0-9].xml'),
        recursive=True)

    # filepaths = [r'C:\Users\sapov\DIME\working-set\MoVi\DublinCore\DublinCore_branch\data\dmeref_331-001_4092.xml']
    data = getdata(filepaths)
    dc = DublinCore()
    df = pd.DataFrame(data, columns=dc.dc_items)

    # create column 'K'
    K = []
    for index, row in df.iterrows():
        val = df.loc[index, 'fileName'].split('_')[1].split('-')[0]
        K.append(val)
    df["K"] = K
    insertcolumn("K", 0)

    # create column 'mov'
    mov = []
    for index, row in df.iterrows():
        val = df.loc[index, 'fileName'].split('_')[1].split('-')[1]
        mov.append(val)
    df["mov"] = mov
    insertcolumn("mov", 1)

    df = df.drop(['fileName'], axis=1)
    df = df.sort_values(by=['K', 'mov'])

    # extract from list
    for index, row in df.iterrows():
        # print(row.K + row.mov)
        for column in df.columns:
            try:
                if len(df.loc[index, column]) == 1:
                    df.loc[index, column] = df.loc[index, column][0]

            except:
                pass

    df.to_csv("./out/validateDC.csv", index=False, encoding='utf-8', sep=';')
    df.to_excel("./out/validateDC.xlsx", index=False, encoding='utf-8')
