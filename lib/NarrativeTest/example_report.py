from installed_clients.KBaseReportClient import KBaseReport
from installed_clients.DataFileUtilClient import DataFileUtil
import uuid
import os
import errno
import shutil


class ExampleReport(object):
    def __init__(self, callback_url, scratch_dir):
        self.scratch_dir = scratch_dir
        self.report_client = KBaseReport(callback_url)
        self.dfu_client = DataFileUtil(callback_url)

    def run_html_links(self, params):
        """
        params is a dict with the following keys:
        * workspace_name: name of the workspace to save the report
        * num_pages: number of html link pages to use
        * initial_page: initial page to show
        Each page is very very simple. Just has some generated text saying it's
        a report on page x.
        """
        num_pages = params.get("num_pages", 1)
        report_dir = os.path.join(self.scratch_dir, str(uuid.uuid4()))
        self._mkdir_p(report_dir)
        html_links = list()
        for i in range(num_pages):
            report_file_content = """
            <html>
                <body>
                    <div>I am an HTML report! This is page {} of {}</div>
                </body>
            </html>
            """.format(i+1, num_pages)
            report_filename = "page{}.html".format(i+1)
            report_file_path = os.path.join(report_dir, report_filename)
            with open(report_file_path, "w") as fout:
                fout.write(report_file_content)
            html_links.append({
                "name": report_filename,
                "description": "Report page {}".format(i+1),
                "path": report_dir
            })
        report = self.report_client.create_extended_report({
            "message": "This is some report message",
            "html_links": html_links,
            "direct_html_link_index": int(params.get("initial_page", 1)) - 1,
            "report_object_name": "NarrativeTest.example_report-" + str(uuid.uuid4()),
            "workspace_name": params["workspace_name"]
        })
        return {
            "report_ref": report["ref"],
            "report_name": report["name"]
        }

    def run(self, params):
        """
        params should have the following:
        * workspace_id = id of the workspace to save the report
        * text_input = some random string for the report
        * checkbox_input = a checkbox so we can add other params
        """
        ws_name = params.get('workspace_name', None)
        if ws_name is None:
            raise ValueError('workspace_name is required!')
        report_dir = self._build_report(params.get('text_input', ''),
                                        params.get('checkbox_input', 0))
        results = self._upload_report(report_dir, ws_name)
        return results

    def _build_report(self, text, checked):
        # make the directory
        report_dir = os.path.join(self.scratch_dir, str(uuid.uuid4()))
        self._mkdir_p(report_dir)
        shutil.copy('/kb/module/lib/NarrativeTest/Kbase_Logo_web.png', report_dir)
        # make some example content
        report_file_content = """
        <html>
        <body>
        <div>
            I am an HTML report. Here's my contents:
        </div>
        <div>
            <b>Text input:</b>
            <pre>
            {}
            </pre>
        </div>
        <div>
            <b>Checkbox checked?</b>
            <br>
            {}
        </div>
        <div>
            <b>Here's a picture</b>
            <br>
            <img src="Kbase_Logo_web.png" width="500px"/>
        </div>
        </body>
        </html>
        """.format(text, "yes" if checked == 1 else "no")

        # write the file to <report_dir>/index.html
        report_filename = os.path.join(report_dir, "index.html")
        with open(report_filename, "w") as report_file:
            report_file.write(report_file_content)
        return report_dir

    def _upload_report(self, report_dir, workspace_name):
        upload_info = self.dfu_client.file_to_shock({
            'file_path': report_dir,
            'pack': 'zip'
        })
        shock_id = upload_info['shock_id']

        report_params = {
            'message': 'This is a report message',
            'direct_html_link_index': 0,
            'html_links': [{
                'shock_id': shock_id,
                'name': 'index.html',
                'description': 'Just an example report'
            }],
            'report_object_name': 'NarrativeTest.example_report' + str(uuid.uuid4()),
            'workspace_name': workspace_name
        }
        report = self.report_client.create_extended_report(report_params)
        return {
            'report_ref': report['ref'],
            'report_name': report['name']
        }

    def _mkdir_p(self, path):
        """
        _mkdir_p: make directory for given path
        """
        if not path:
            return
        try:
            os.makedirs(path)
        except OSError as exc:
            if exc.errno == errno.EEXIST and os.path.isdir(path):
                pass
            else:
                raise
