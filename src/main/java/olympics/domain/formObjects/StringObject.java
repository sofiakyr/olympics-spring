package olympics.domain.formObjects;

/**
 * Created by c1519287 on 08/12/2016.
 */
public class StringObject {
    String value;

    public StringObject(String value) {
        this.value = value;
    }

    public StringObject() {
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
