# -*- coding: utf-8 -*-
import unittest
import os  # noqa: F401
import json  # noqa: F401
import time
import requests

from os import environ
try:
    from ConfigParser import ConfigParser  # py2
except:
    from configparser import ConfigParser  # py3

from pprint import pprint  # noqa: F401

from biokbase.workspace.client import Workspace as workspaceService
from NarrativeTest.NarrativeTestImpl import NarrativeTest
from NarrativeTest.NarrativeTestServer import MethodContext
from NarrativeTest.authclient import KBaseAuth as _KBaseAuth


class NarrativeTestTest(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        token = environ.get('KB_AUTH_TOKEN', None)
        config_file = environ.get('KB_DEPLOYMENT_CONFIG', None)
        cls.cfg = {}
        config = ConfigParser()
        config.read(config_file)
        for nameval in config.items('NarrativeTest'):
            cls.cfg[nameval[0]] = nameval[1]
        # Getting username from Auth profile for token
        authServiceUrl = cls.cfg['auth-service-url']
        auth_client = _KBaseAuth(authServiceUrl)
        user_id = auth_client.get_user(token)
        # WARNING: don't call any logging methods on the context object,
        # it'll result in a NoneType error
        cls.ctx = MethodContext(None)
        cls.ctx.update({'token': token,
                        'user_id': user_id,
                        'provenance': [
                            {'service': 'NarrativeTest',
                             'method': 'please_never_use_it_in_production',
                             'method_params': []
                             }],
                        'authenticated': 1})
        cls.wsURL = cls.cfg['workspace-url']
        cls.wsClient = workspaceService(cls.wsURL)
        cls.serviceImpl = NarrativeTest(cls.cfg)
        cls.scratch = cls.cfg['scratch']
        cls.callback_url = os.environ['SDK_CALLBACK_URL']

    @classmethod
    def tearDownClass(cls):
        if hasattr(cls, 'wsName'):
            cls.wsClient.delete_workspace({'workspace': cls.wsName})
            print('Test workspace was deleted')

    def getWsClient(self):
        return self.__class__.wsClient

    def getWsName(self):
        if hasattr(self.__class__, 'wsName'):
            return self.__class__.wsName
        suffix = int(time.time() * 1000)
        wsName = "test_NarrativeTest_" + str(suffix)
        ret = self.getWsClient().create_workspace({'workspace': wsName})  # noqa
        self.__class__.wsId = ret[0]
        self.__class__.wsName = wsName
        return wsName

    def getWsId(self):
        if not hasattr(self.__class__, 'wsId'):
            self.getWsName()
        return self.__class__.wsId

    def getImpl(self):
        return self.__class__.serviceImpl

    def getContext(self):
        return self.__class__.ctx

    # NOTE: According to Python unittest naming rules test method names should start from 'test'. # noqa
    def test_your_method(self):
        # Prepare test objects in workspace if needed using
        # self.getWsClient().save_objects({'workspace': self.getWsName(),
        #                                  'objects': []})
        #
        # Run your method by
        # ret = self.getImpl().your_method(self.getContext(), parameters...)
        #
        # Check returned data with
        # self.assertEqual(ret[...], ...) or other unittest methods
        pass

    def test_example_report(self):
        report_result = self.getImpl().example_report(
            self.getContext(),
            {
                'workspace_name': self.getWsName(),
                'text_input': 'i am text. hear me mumble.',
                'checkbox_input': 1
            }
        )[0]
        self.assertIn('report_ref', report_result)
        self.assertIn('report_name', report_result)

    def test_report_html_links(self):
        report_result = self.getImpl().report_html_links(
            self.getContext(),
            {
                "workspace_name": self.getWsName(),
                "num_pages": 3,
                "initial_page": 1
            }
        )[0]
        self.assertIn("report_ref", report_result)
        self.assertIn("report_name", report_result)
        ws = self.getWsClient()
        report = ws.get_objects2({"objects": [{"ref": report_result["report_ref"]}]})["data"][0]["data"]
        self.assertEqual(len(report["html_links"]), 3)
        self.assertEqual(report["direct_html_link_index"], 0)
        self.assertIsNone(report["direct_html"])

    def test_report_html_links_direct(self):
        report_result = self.getImpl().report_html_links(
            self.getContext(),
            {
                "workspace_name": self.getWsName(),
                "num_pages": 3,
                "initial_page": 2,
                "include_direct_html": 1
            }
        )[0]
        self.assertIn("report_ref", report_result)
        self.assertIn("report_name", report_result)
        ws = self.getWsClient()
        report = ws.get_objects2({"objects": [{"ref": report_result["report_ref"]}]})["data"][0]["data"]
        self.assertEqual(len(report["html_links"]), 3)
        self.assertEqual(report["direct_html_link_index"], 1)
        self.assertIsNotNone(report["direct_html"])

    def test_report_html_links_only_direct(self):
        report_result = self.getImpl().report_html_links(
            self.getContext(),
            {
                "workspace_name": self.getWsName(),
                "num_pages": 0,
                "include_direct_html": 1
            }
        )[0]
        self.assertIn("report_ref", report_result)
        self.assertIn("report_name", report_result)
        ws = self.getWsClient()
        report = ws.get_objects2({"objects": [{"ref": report_result["report_ref"]}]})["data"][0]["data"]
        self.assertEqual(len(report["html_links"]), 0)
        self.assertEqual(report["direct_html_link_index"], None)
        self.assertIsNotNone(report["direct_html"])

    def test_report_html_links_files(self):
        report_result = self.getImpl().report_html_links(
            self.getContext(),
            {
                "workspace_name": self.getWsName(),
                "num_pages": 0,
                "include_direct_html": 1,
                "num_files": 2
            }
        )[0]
        self.assertIn("report_ref", report_result)
        self.assertIn("report_name", report_result)
        ws = self.getWsClient()
        report = ws.get_objects2({"objects": [{"ref": report_result["report_ref"]}]})["data"][0]["data"]
        self.assertEqual(len(report["html_links"]), 0)
        self.assertEqual(report["direct_html_link_index"], None)
        self.assertIsNotNone(report["direct_html"])
        self.assertEqual(len(report["file_links"]), 2)

    def test_app_succeed(self):
        param = "some_param"
        param_ret = self.getImpl().app_succeed(self.getContext(), param)[0]
        self.assertEqual(param, param_ret)

    def test_app_fail(self):
        with self.assertRaises(RuntimeError) as e:
            self.getImpl().app_fail(self.getContext())
        self.assertIn("Raising an error because that's what we do here.", str(e.exception))

    def test_app_sleep(self):
        naptime = 3
        naptime_ret = self.getImpl().app_sleep(self.getContext(), {"naptime": naptime, "fail": 0})[0]
        self.assertEqual(naptime, naptime_ret)

        with self.assertRaises(RuntimeError) as e:
            self.getImpl().app_sleep(self.getContext(), {"naptime": 1, "fail": 1})
        self.assertIn("App woke up from its nap very cranky!", str(e.exception))

    def test_app_logs(self):
        num_lines = 5
        ret = self.getImpl().app_logs(self.getContext(), {"num_lines": num_lines})[0]
        self.assertIn("prefix", ret)
        self.assertEqual(10, len(ret["prefix"]))
        self.assertEqual(ret.get("num_lines"), num_lines)

