# -*- coding: utf-8 -*-
#BEGIN_HEADER
from installed_clients.kb_uploadmethodsClient import kb_uploadmethods
from NarrativeTest.example_report import ExampleReport
from copy import deepcopy
import os
import time
#END_HEADER


class NarrativeTest:
    '''
    Module Name:
    NarrativeTest

    Module Description:
    A KBase module: NarrativeTest
    '''

    ######## WARNING FOR GEVENT USERS ####### noqa
    # Since asynchronous IO can lead to methods - even the same method -
    # interrupting each other, you must be *very* careful when using global
    # state. A method could easily clobber the state set by another while
    # the latter method is running.
    ######################################### noqa
    VERSION = "0.0.2"
    GIT_URL = "https://github.com/briehl/narrative-test"
    GIT_COMMIT_HASH = "5b360a818f37303e79f7df1ba74cd68e3dd04589"

    #BEGIN_CLASS_HEADER
    #END_CLASS_HEADER

    # config contains contents of config file in a hash or None if it couldn't
    # be found
    def __init__(self, config):
        #BEGIN_CONSTRUCTOR
        self.callbackURL = os.environ['SDK_CALLBACK_URL']
        self.scratch_dir = config['scratch']
        self.config = config
        #END_CONSTRUCTOR
        pass


    def test_async_job(self, ctx, params):
        """
        Asynchronously copies a genome into another genome. Ta-daaa!
        :param params: instance of type "TestAsyncJobParams" -> structure:
           parameter "workspace" of type "workspace_name" (A string
           representing a workspace name.), parameter "input_genome_name" of
           type "genome_name", parameter "output_genome_name" of type
           "genome_name"
        :returns: instance of type "TestAsyncJobResults" (The workspace ID
           for a ContigSet data object. @id ws KBaseGenomes.ContigSet) ->
           structure: parameter "report_name" of String, parameter
           "report_ref" of String, parameter "new_genome_ref" of type
           "ws_contigset_id"
        """
        # ctx is the context object
        # return variables are: returnVal
        #BEGIN test_async_job
        #END test_async_job

        # At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method test_async_job return value ' +
                             'returnVal is not type dict as required.')
        # return the results
        return [returnVal]

    def test_editor(self, ctx, editor, workspace):
        """
        :param editor: instance of String
        :param workspace: instance of type "workspace_name" (A string
           representing a workspace name.)
        :returns: instance of type "TestEditorResults" -> structure:
           parameter "report_name" of String, parameter "report_ref" of
           String, parameter "output" of String
        """
        # ctx is the context object
        # return variables are: returnVal
        #BEGIN test_editor
        #END test_editor

        # At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method test_editor return value ' +
                             'returnVal is not type dict as required.')
        # return the results
        return [returnVal]

    def save_reads_set_v1(self, ctx, inputs):
        """
        :param inputs: instance of unspecified object
        :returns: instance of unspecified object
        """
        # ctx is the context object
        # return variables are: outputs
        #BEGIN save_reads_set_v1
        #END save_reads_set_v1

        # At some point might do deeper type checking...
        if not isinstance(outputs, object):
            raise ValueError('Method save_reads_set_v1 return value ' +
                             'outputs is not type object as required.')
        # return the results
        return [outputs]

    def test_param_groups(self, ctx, params):
        """
        :param params: instance of type "TestParamGroupsParams" -> structure:
           parameter "workspace" of type "workspace_name" (A string
           representing a workspace name.), parameter "param_group" of list
           of type "SimpleParamGroup" -> structure: parameter "genome_ref" of
           String, parameter "free_text" of list of String, parameter "check"
           of Long
        :returns: instance of type "ReportOutput" -> structure: parameter
           "report_name" of String, parameter "report_ref" of String
        """
        # ctx is the context object
        # return variables are: returnVal
        #BEGIN test_param_groups
        #END test_param_groups

        # At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method test_param_groups return value ' +
                             'returnVal is not type dict as required.')
        # return the results
        return [returnVal]

    def test_input_mapping(self, ctx, params):
        """
        :param params: instance of type "SimpleTestObject" -> structure:
           parameter "workspace" of type "workspace_id" (A string
           representing a workspace id.), parameter "file_path" of String
        :returns: instance of unspecified object
        """
        # ctx is the context object
        # return variables are: outputs
        #BEGIN test_input_mapping
        #END test_input_mapping

        # At some point might do deeper type checking...
        if not isinstance(outputs, object):
            raise ValueError('Method test_input_mapping return value ' +
                             'outputs is not type object as required.')
        # return the results
        return [outputs]

    def generic_test(self, ctx, params):
        """
        :param params: instance of unspecified object
        :returns: instance of unspecified object
        """
        # ctx is the context object
        # return variables are: outputs
        #BEGIN generic_test
        #END generic_test

        # At some point might do deeper type checking...
        if not isinstance(outputs, object):
            raise ValueError('Method generic_test return value ' +
                             'outputs is not type object as required.')
        # return the results
        return [outputs]

    def import_reads_from_staging(self, ctx, params):
        """
        :param params: instance of type "UploadReadsParams" -> structure:
           parameter "import_type" of String, parameter
           "fastq_fwd_staging_file_name" of String, parameter
           "fastq_rev_staging_file_name" of String, parameter
           "sra_staging_file_name" of String, parameter "sequencing_tech" of
           type "sequencing_tech" (sequencing_tech: sequencing technology
           name: output reads file name workspace_name: workspace name/ID of
           the object import_type: either FASTQ or SRA For files in user's
           staging area: fastq_fwd_or_sra_staging_file_name: single-end fastq
           file name Or forward/left paired-end fastq file name from user's
           staging area Or SRA staging file fastq_rev_staging_file_name:
           reverse/right paired-end fastq file name user's staging area e.g.
           for file: /data/bulk/user_name/file_name staging_file_subdir_path
           is file_name for file:
           /data/bulk/user_name/subdir_1/subdir_2/file_name
           staging_file_subdir_path is subdir_1/subdir_2/file_name Optional
           Params: single_genome: whether the reads are from a single genome
           or a metagenome. interleaved: whether reads is interleaved
           insert_size_mean: mean (average) insert length
           insert_size_std_dev: standard deviation of insert lengths
           read_orientation_outward: whether reads in a pair point outward),
           parameter "workspace_name" of type "workspace_name" (A string
           representing a workspace name.), parameter "name" of String,
           parameter "single_genome" of type "single_genome", parameter
           "interleaved" of type "interleaved", parameter "insert_size_mean"
           of type "insert_size_mean", parameter "insert_size_std_dev" of
           type "insert_size_std_dev", parameter "read_orientation_outward"
           of type "read_orientation_outward"
        :returns: instance of type "UploadMethodResult" -> structure:
           parameter "obj_ref" of type "obj_ref", parameter "report_name" of
           type "report_name", parameter "report_ref" of type "report_ref"
        """
        # ctx is the context object
        # return variables are: returnVal
        #BEGIN import_reads_from_staging
        upload_client = kb_uploadmethods(self.callbackURL)
        returnVal = upload_client.import_reads_from_staging(params)
        #END import_reads_from_staging

        # At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method import_reads_from_staging return value ' +
                             'returnVal is not type dict as required.')
        # return the results
        return [returnVal]

    def example_report(self, ctx, params):
        """
        :param params: instance of type "ExampleReportParams" -> structure:
           parameter "text_input" of String, parameter "checkbox_input" of
           Long, parameter "workspace_name" of String
        :returns: instance of type "ExampleReportResult" -> structure:
           parameter "report_name" of type "report_name", parameter
           "report_ref" of type "report_ref"
        """
        # ctx is the context object
        # return variables are: result
        #BEGIN example_report
        report_maker = ExampleReport(self.callbackURL, self.scratch_dir)
        result = report_maker.run(params)
        #END example_report

        # At some point might do deeper type checking...
        if not isinstance(result, dict):
            raise ValueError('Method example_report return value ' +
                             'result is not type dict as required.')
        # return the results
        return [result]

    def introspect_job_info(self, ctx, params):
        """
        :param params: instance of type "IntrospectParams" -> structure:
           parameter "param1" of String, parameter "param2" of String
        :returns: instance of type "IntrospectResult" -> structure: parameter
           "context" of unspecified object, parameter "config" of unspecified
           object, parameter "params" of type "IntrospectParams" ->
           structure: parameter "param1" of String, parameter "param2" of
           String
        """
        # ctx is the context object
        # return variables are: result
        #BEGIN introspect_job_info
        context_copy = deepcopy(ctx)
        if "token" in context_copy:
            context_copy["token"] = "lol, no"
        config_copy = deepcopy(self.config)
        if "token" in config_copy:
            config_copy["token"] = "lol, no"
        result = {
            "context": context_copy,
            "config": config_copy,
            "params": params
        }
        #END introspect_job_info

        # At some point might do deeper type checking...
        if not isinstance(result, dict):
            raise ValueError('Method introspect_job_info return value ' +
                             'result is not type dict as required.')
        # return the results
        return [result]

    def app_succeed(self, ctx, param):
        """
        A simple function that should always succeed immediately (just returns the string passed to it)
        :param param: instance of String
        :returns: instance of String
        """
        # ctx is the context object
        # return variables are: param
        #BEGIN app_succeed
        #END app_succeed

        # At some point might do deeper type checking...
        if not isinstance(param, str):
            raise ValueError('Method app_succeed return value ' +
                             'param is not type str as required.')
        # return the results
        return [param]

    def app_fail(self, ctx):
        """
        A simple function that always fails, throwing an error.
        """
        # ctx is the context object
        #BEGIN app_fail
        raise RuntimeError("Raising an error because that's what we do here.")
        #END app_fail
        pass

    def app_sleep(self, ctx, param):
        """
        A slightly more complex function that runs for a given time (in seconds) before exiting. (negative values are treated as zero)
        Can also end in failure. If successful, returns how long it slept.
        :param param: instance of type "SleepParams" (naptime - int - sleep
           time in seconds fail - boolean - if true, this always throws an
           error) -> structure: parameter "naptime" of Long, parameter "fail"
           of type "boolean" (if 0, treat as false, any other value treat as
           true)
        :returns: instance of Long
        """
        # ctx is the context object
        # return variables are: naptime
        #BEGIN app_sleep
        naptime = param.get('naptime', 0)
        if not isinstance(naptime, int) or naptime < 0:
            naptime = 0
        time.sleep(naptime)
        if param.get('fail', 0):
            raise RuntimeError('App woke up from its nap very cranky!')
        #END app_sleep

        # At some point might do deeper type checking...
        if not isinstance(naptime, int):
            raise ValueError('Method app_sleep return value ' +
                             'naptime is not type int as required.')
        # return the results
        return [naptime]
    def status(self, ctx):
        #BEGIN_STATUS
        returnVal = {'state': "OK",
                     'message': "",
                     'version': self.VERSION,
                     'git_url': self.GIT_URL,
                     'git_commit_hash': self.GIT_COMMIT_HASH}
        #END_STATUS
        return [returnVal]
