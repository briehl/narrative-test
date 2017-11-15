
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
 * <p>Original spec-file type: SimpleParamGroup</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "genome_ref",
    "free_text",
    "check"
})
public class SimpleParamGroup {

    @JsonProperty("genome_ref")
    private java.lang.String genomeRef;
    @JsonProperty("free_text")
    private List<String> freeText;
    @JsonProperty("check")
    private Long check;
    private Map<java.lang.String, Object> additionalProperties = new HashMap<java.lang.String, Object>();

    @JsonProperty("genome_ref")
    public java.lang.String getGenomeRef() {
        return genomeRef;
    }

    @JsonProperty("genome_ref")
    public void setGenomeRef(java.lang.String genomeRef) {
        this.genomeRef = genomeRef;
    }

    public SimpleParamGroup withGenomeRef(java.lang.String genomeRef) {
        this.genomeRef = genomeRef;
        return this;
    }

    @JsonProperty("free_text")
    public List<String> getFreeText() {
        return freeText;
    }

    @JsonProperty("free_text")
    public void setFreeText(List<String> freeText) {
        this.freeText = freeText;
    }

    public SimpleParamGroup withFreeText(List<String> freeText) {
        this.freeText = freeText;
        return this;
    }

    @JsonProperty("check")
    public Long getCheck() {
        return check;
    }

    @JsonProperty("check")
    public void setCheck(Long check) {
        this.check = check;
    }

    public SimpleParamGroup withCheck(Long check) {
        this.check = check;
        return this;
    }

    @JsonAnyGetter
    public Map<java.lang.String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperties(java.lang.String name, Object value) {
        this.additionalProperties.put(name, value);
    }

    @Override
    public java.lang.String toString() {
        return ((((((((("SimpleParamGroup"+" [genomeRef=")+ genomeRef)+", freeText=")+ freeText)+", check=")+ check)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
