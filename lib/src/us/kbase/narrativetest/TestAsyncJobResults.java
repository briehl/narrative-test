
package us.kbase.narrativetest;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * <p>Original spec-file type: TestAsyncJobResults</p>
 * <pre>
 * The workspace ID for a ContigSet data object.
 * @id ws KBaseGenomes.ContigSet
 * </pre>
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "report_name",
    "report_ref",
    "new_genome_ref"
})
public class TestAsyncJobResults {

    @JsonProperty("report_name")
    private String reportName;
    @JsonProperty("report_ref")
    private String reportRef;
    @JsonProperty("new_genome_ref")
    private String newGenomeRef;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("report_name")
    public String getReportName() {
        return reportName;
    }

    @JsonProperty("report_name")
    public void setReportName(String reportName) {
        this.reportName = reportName;
    }

    public TestAsyncJobResults withReportName(String reportName) {
        this.reportName = reportName;
        return this;
    }

    @JsonProperty("report_ref")
    public String getReportRef() {
        return reportRef;
    }

    @JsonProperty("report_ref")
    public void setReportRef(String reportRef) {
        this.reportRef = reportRef;
    }

    public TestAsyncJobResults withReportRef(String reportRef) {
        this.reportRef = reportRef;
        return this;
    }

    @JsonProperty("new_genome_ref")
    public String getNewGenomeRef() {
        return newGenomeRef;
    }

    @JsonProperty("new_genome_ref")
    public void setNewGenomeRef(String newGenomeRef) {
        this.newGenomeRef = newGenomeRef;
    }

    public TestAsyncJobResults withNewGenomeRef(String newGenomeRef) {
        this.newGenomeRef = newGenomeRef;
        return this;
    }

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperties(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

    @Override
    public String toString() {
        return ((((((((("TestAsyncJobResults"+" [reportName=")+ reportName)+", reportRef=")+ reportRef)+", newGenomeRef=")+ newGenomeRef)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
