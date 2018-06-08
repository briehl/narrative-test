
package us.kbase.narrativetest;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import us.kbase.common.service.UObject;


/**
 * <p>Original spec-file type: IntrospectResult</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "context",
    "params"
})
public class IntrospectResult {

    @JsonProperty("context")
    private UObject context;
    /**
     * <p>Original spec-file type: IntrospectParams</p>
     * 
     * 
     */
    @JsonProperty("params")
    private IntrospectParams params;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("context")
    public UObject getContext() {
        return context;
    }

    @JsonProperty("context")
    public void setContext(UObject context) {
        this.context = context;
    }

    public IntrospectResult withContext(UObject context) {
        this.context = context;
        return this;
    }

    /**
     * <p>Original spec-file type: IntrospectParams</p>
     * 
     * 
     */
    @JsonProperty("params")
    public IntrospectParams getParams() {
        return params;
    }

    /**
     * <p>Original spec-file type: IntrospectParams</p>
     * 
     * 
     */
    @JsonProperty("params")
    public void setParams(IntrospectParams params) {
        this.params = params;
    }

    public IntrospectResult withParams(IntrospectParams params) {
        this.params = params;
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
        return ((((((("IntrospectResult"+" [context=")+ context)+", params=")+ params)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
