
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
 * <p>Original spec-file type: IntrospectParams</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "param1",
    "param2"
})
public class IntrospectParams {

    @JsonProperty("param1")
    private String param1;
    @JsonProperty("param2")
    private String param2;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("param1")
    public String getParam1() {
        return param1;
    }

    @JsonProperty("param1")
    public void setParam1(String param1) {
        this.param1 = param1;
    }

    public IntrospectParams withParam1(String param1) {
        this.param1 = param1;
        return this;
    }

    @JsonProperty("param2")
    public String getParam2() {
        return param2;
    }

    @JsonProperty("param2")
    public void setParam2(String param2) {
        this.param2 = param2;
    }

    public IntrospectParams withParam2(String param2) {
        this.param2 = param2;
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
        return ((((((("IntrospectParams"+" [param1=")+ param1)+", param2=")+ param2)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
