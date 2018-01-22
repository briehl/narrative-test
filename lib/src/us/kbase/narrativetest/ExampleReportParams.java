
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
 * <p>Original spec-file type: ExampleReportParams</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "text_input",
    "checkbox_input",
    "workspace_id"
})
public class ExampleReportParams {

    @JsonProperty("text_input")
    private String textInput;
    @JsonProperty("checkbox_input")
    private Long checkboxInput;
    @JsonProperty("workspace_id")
    private Long workspaceId;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("text_input")
    public String getTextInput() {
        return textInput;
    }

    @JsonProperty("text_input")
    public void setTextInput(String textInput) {
        this.textInput = textInput;
    }

    public ExampleReportParams withTextInput(String textInput) {
        this.textInput = textInput;
        return this;
    }

    @JsonProperty("checkbox_input")
    public Long getCheckboxInput() {
        return checkboxInput;
    }

    @JsonProperty("checkbox_input")
    public void setCheckboxInput(Long checkboxInput) {
        this.checkboxInput = checkboxInput;
    }

    public ExampleReportParams withCheckboxInput(Long checkboxInput) {
        this.checkboxInput = checkboxInput;
        return this;
    }

    @JsonProperty("workspace_id")
    public Long getWorkspaceId() {
        return workspaceId;
    }

    @JsonProperty("workspace_id")
    public void setWorkspaceId(Long workspaceId) {
        this.workspaceId = workspaceId;
    }

    public ExampleReportParams withWorkspaceId(Long workspaceId) {
        this.workspaceId = workspaceId;
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
        return ((((((((("ExampleReportParams"+" [textInput=")+ textInput)+", checkboxInput=")+ checkboxInput)+", workspaceId=")+ workspaceId)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
