/*
A KBase module: NarrativeTest
*/

module NarrativeTest {
    /* if 0, treat as false, any other value treat as true */
    typedef int boolean;

    /*
        A string representing a ContigSet id.
    */
    typedef string contigset_id;

    /*
        A string representing a workspace name.
    */
    typedef string workspace_name;

    typedef string workspace_ref;
    typedef string upa;

    /*
        A string representing a workspace id.
    */
    typedef string workspace_id;

    typedef string ws_contigset_id;
    typedef string genome_name;

    typedef structure {
        workspace_name workspace;
        genome_name input_genome_name;
        genome_name output_genome_name;
    } TestAsyncJobParams;

    typedef mapping<string, string> somemap;

    typedef mapping<string, string> othermap;

    /*
        The workspace ID for a ContigSet data object.
        @id ws KBaseGenomes.ContigSet
    */
    typedef structure {
        string report_name;
        string report_ref;
        ws_contigset_id new_genome_ref;
    } TestAsyncJobResults;

    /*
        Asynchronously copies a genome into another genome. Ta-daaa!
    */
    funcdef test_async_job(TestAsyncJobParams params) returns (TestAsyncJobResults) authentication required;

    typedef structure {
        string report_name;
        string report_ref;
        string output;
    } TestEditorResults;

    funcdef test_editor(string editor, workspace_name workspace) returns (TestEditorResults) authentication required;

    funcdef save_reads_set_v1(UnspecifiedObject inputs) returns (UnspecifiedObject outputs) authentication required;


    typedef structure {
        string report_name;
        string report_ref;
    } ReportOutput;

    typedef structure {
        string genome_ref;
        list<string> free_text;
        int check;
        string output_obj_name;
    } SimpleParamGroup;

    typedef structure {
        workspace_name workspace;
        list<SimpleParamGroup> param_group;
    } TestParamGroupsParams;

    funcdef test_param_groups(TestParamGroupsParams params) returns (ReportOutput) authentication required;

    typedef structure {
        workspace_id workspace;
        string file_path;
    } SimpleTestObject;

    funcdef test_input_mapping(SimpleTestObject params) returns (UnspecifiedObject outputs) authentication required;

    funcdef generic_test(UnspecifiedObject params) returns (UnspecifiedObject outputs) authentication required;


    /* WRAPPING EXTERNAL IMPORTERS FOR TINKERING. */
    /*
      sequencing_tech: sequencing technology
      name: output reads file name
      workspace_name: workspace name/ID of the object
      import_type: either FASTQ or SRA

      For files in user's staging area:
      fastq_fwd_or_sra_staging_file_name: single-end fastq file name Or forward/left paired-end fastq file name from user's staging area Or SRA staging file
      fastq_rev_staging_file_name: reverse/right paired-end fastq file name user's staging area
      e.g.
        for file: /data/bulk/user_name/file_name
        staging_file_subdir_path is file_name
        for file: /data/bulk/user_name/subdir_1/subdir_2/file_name
        staging_file_subdir_path is subdir_1/subdir_2/file_name

      Optional Params:
      single_genome: whether the reads are from a single genome or a metagenome.
      interleaved: whether reads is interleaved
      insert_size_mean: mean (average) insert length
      insert_size_std_dev: standard deviation of insert lengths
      read_orientation_outward: whether reads in a pair point outward
    */
    typedef string sequencing_tech;
    typedef string interleaved;
    typedef string insert_size_mean;
    typedef string insert_size_std_dev;
    typedef string read_orientation_outward;
    typedef string obj_ref;
    typedef string report_name;
    typedef string report_ref;
    typedef string single_genome;

    typedef structure {
      string import_type;
      string fastq_fwd_staging_file_name;
      string fastq_rev_staging_file_name;
      string sra_staging_file_name;
      sequencing_tech sequencing_tech;
      workspace_name workspace_name;
      string name;
      single_genome single_genome;
      interleaved interleaved;
      insert_size_mean insert_size_mean;
      insert_size_std_dev insert_size_std_dev;
      read_orientation_outward read_orientation_outward;
    } UploadReadsParams;

    typedef structure {
      obj_ref obj_ref;
      report_name report_name;
      report_ref report_ref;
    } UploadMethodResult;

    funcdef import_reads_from_staging(UploadReadsParams params)
      returns (UploadMethodResult returnVal) authentication required;

    typedef structure {
      string text_input;
      int checkbox_input;
      string workspace_name;
    } ExampleReportParams;

    typedef structure {
      report_name report_name;
      report_ref report_ref;
    } ExampleReportResult;

    funcdef example_report(ExampleReportParams params)
      returns (ExampleReportResult result) authentication required;

    typedef structure {
      int num_pages;
      int initial_page;
      string workspace_name;
      boolean include_direct_html;
      int num_files;
    } ReportHtmlLinksParams;

    funcdef report_html_links(ReportHtmlLinksParams params)
      returns (ExampleReportResult result) authentication required;

    typedef structure {
        string param1;
        string param2;
    } IntrospectParams;

    typedef structure {
        UnspecifiedObject context;
        UnspecifiedObject config;
        IntrospectParams params;
    } IntrospectResult;

    funcdef introspect_job_info(IntrospectParams params) returns (IntrospectResult result) authentication required;

    /*
      A simple function that should always succeed immediately (just returns the string passed to it)
    */
    funcdef app_succeed(string param) returns (string param) authentication required;

    /*
      A simple function that always fails, throwing an error.
    */
    funcdef app_fail() returns () authentication required;

    /*
      naptime - int - sleep time in seconds
      fail - boolean - if true, this always throws an error
    */
    typedef structure {
        int naptime;
        boolean fail;
    } SleepParams;

    /*
      A slightly more complex function that runs for a given time (in seconds) before exiting. (negative values are treated as zero)
      Can also end in failure. If successful, returns how long it slept.
    */
    funcdef app_sleep(SleepParams param) returns (int naptime) authentication required;

    typedef structure {
        int num_lines;
    } AppLogParams;

    typedef structure {
        int num_lines;
        string prefix;
    } AppLogResult;

    /*
      A simple app that puts out a number of log lines, one per second, until done. This way we can test the log viewer.
    */
    funcdef app_logs(AppLogParams param) returns (AppLogResult result) authentication required;


    typedef structure {
      string input_obj_name;
      workspace_ref input_obj_ref;
      workspace_ref input_obj_unresolved_ref;
      upa input_obj_resolved_ref;
      upa input_obj_upa;
      list<string> input_obj_names;
      list<workspace_ref> input_obj_refs;
      list<workspace_ref> input_obj_unresolved_refs;
      list<upa> input_obj_resolved_refs;
      list<upa> input_obj_upas;
      int single_int;
      list<int> list_of_ints;
      float single_float;
      list<float> list_of_floats;
      string single_string_int;
      list<string> list_of_string_ints;
    } InputTransformParams;

    funcdef test_input_transform(InputTransformParams params) returns (InputTransformParams result) authentication required;
};
