package com.efx.pet.batch;

import com.efx.pet.batch.service.GeneratorService;
import com.efx.pet.batch.utils.ReportUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.cli.*;

@Slf4j
public class Main {

    public static final String XSL_OPTION = "xsl";
    public static final String XML_OPTION = "xml";
    public static final String PDF_OPTION = "pdf";
    public static final String OPEN_OPTION = "open";
    public static final String HELP_OPTION = "help";
    public static final String APPLICATION_NAME = "xsltopdf";

    public static void main(String[] args) throws Exception {
        CommandLineParser parser = new DefaultParser();
        final Options options = buildOptions();

        String header = "[<xsl> [<xml> [<pdf> ...\n       Options, flags and arguments may be in any order";
        String footer = "This application allows to generate pdf reports from files specified as command line arguments.";
        HelpFormatter helpFormatter = new HelpFormatter();

        try {
            CommandLine line = parser.parse(options, args);
            if (line.hasOption(HELP_OPTION)) {
                helpFormatter.printHelp(APPLICATION_NAME, header, options, footer, false);
                return;
            }
            String xslFile = line.getOptionValue(XSL_OPTION);
            String xmlFile = line.getOptionValue(XML_OPTION);
            String pdfFile = line.getOptionValue(PDF_OPTION);
            GeneratorService generatorService = new GeneratorService(xslFile, xmlFile, pdfFile, true);
            generatorService.generateReport();

            if (line.hasOption(OPEN_OPTION)) {
                ReportUtils.openGeneratedFile(pdfFile);
            }

        } catch (ParseException exp) {
            System.err.println(exp.getMessage());
            helpFormatter.printHelp("report-generator", header, options, footer, false);
        }
    }

    private static Options buildOptions() {
        final Options options = new Options();
        options.addOption(new Option(XSL_OPTION, true, "path to input xsl file"));
        options.addOption(new Option(XML_OPTION, true, "path to input xml file"));
        options.addOption(new Option(PDF_OPTION, true, "path to output pdf file"));
        options.addOption(Option.builder(OPEN_OPTION).hasArg(false).longOpt(OPEN_OPTION).required(false).desc("open generated pdf file").build());
        options.addOption(Option.builder(HELP_OPTION).hasArg(false).longOpt(HELP_OPTION).required(false).desc("show help").build());
        return options;
    }
}
