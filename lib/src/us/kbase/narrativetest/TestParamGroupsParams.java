
package us.kbase.narrativetest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * <p>Original spec-file type: TestParamGroupsParams</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "workspace",
    "param_group"
})
public class TestParamGroupsParams {

    @JsonProperty("workspace")
    private String workspace;
    @JsonProperty("param_group")
    private List<SimpleParamGroup> paramGroup;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("workspace")
    public String getWorkspace() {
        return workspace;
    }

    @JsonProperty("workspace")
    public void setWorkspace(String workspace) {
        this.workspace = workspace;
    }

    public TestParamGroupsParams withWorkspace(String workspace) {
        this.workspace = workspace;
        return this;
    }

    @JsonProperty("param_group")
    public List<SimpleParamGroup> getParamGroup() {
        return paramGroup;
    }

    @JsonProperty("param_group")
    public void setParamGroup(List<SimpleParamGroup> paramGroup) {
        this.paramGroup = paramGroup;
    }

    public TestParamGroupsParams withParamGroup(List<SimpleParamGroup> paramGroup) {
        this.paramGroup = paramGroup;
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
        return ((((((("TestParamGroupsParams"+" [workspace=")+ workspace)+", paramGroup=")+ paramGroup)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
