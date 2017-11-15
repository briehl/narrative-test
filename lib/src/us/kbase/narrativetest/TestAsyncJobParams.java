
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
 * <p>Original spec-file type: TestAsyncJobParams</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "workspace",
    "input_genome_name",
    "output_genome_name"
})
public class TestAsyncJobParams {

    @JsonProperty("workspace")
    private String workspace;
    @JsonProperty("input_genome_name")
    private String inputGenomeName;
    @JsonProperty("output_genome_name")
    private String outputGenomeName;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("workspace")
    public String getWorkspace() {
        return workspace;
    }

    @JsonProperty("workspace")
    public void setWorkspace(String workspace) {
        this.workspace = workspace;
    }

    public TestAsyncJobParams withWorkspace(String workspace) {
        this.workspace = workspace;
        return this;
    }

    @JsonProperty("input_genome_name")
    public String getInputGenomeName() {
        return inputGenomeName;
    }

    @JsonProperty("input_genome_name")
    public void setInputGenomeName(String inputGenomeName) {
        this.inputGenomeName = inputGenomeName;
    }

    public TestAsyncJobParams withInputGenomeName(String inputGenomeName) {
        this.inputGenomeName = inputGenomeName;
        return this;
    }

    @JsonProperty("output_genome_name")
    public String getOutputGenomeName() {
        return outputGenomeName;
    }

    @JsonProperty("output_genome_name")
    public void setOutputGenomeName(String outputGenomeName) {
        this.outputGenomeName = outputGenomeName;
    }

    public TestAsyncJobParams withOutputGenomeName(String outputGenomeName) {
        this.outputGenomeName = outputGenomeName;
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
        return ((((((((("TestAsyncJobParams"+" [workspace=")+ workspace)+", inputGenomeName=")+ inputGenomeName)+", outputGenomeName=")+ outputGenomeName)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
