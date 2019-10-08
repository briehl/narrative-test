/*
A KBase module: NarrativeTest
*/

module NarrativeTest {
    /*
        A string representing a ContigSet id.
    */
    typedef string contigset_id;

    /*
        A string representing a workspace name.
    */
    typedef string workspace_name;

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
        string param1;
        string param2;
    } IntrospectParams;

    typedef structure {
        UnspecifiedObject context;
        UnspecifiedObject config;
        IntrospectParams params;
    } IntrospectResult;

    funcdef introspect_job_info(IntrospectParams params) returns (IntrospectResult result) authentication required;
};
