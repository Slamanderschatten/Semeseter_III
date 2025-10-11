public class Person {
    private String name;
    private String vorname;

    private Fahrrad meinFahrrad;

    public Person(String name, String vorname) {
        this.name = name;
        this.vorname = vorname;
    }

    public void setMeinFahrrad(Fahrrad meinFahrrad) {
        this.meinFahrrad = meinFahrrad;
    }

    public void fahrradFahren(){
        meinFahrrad.fahren();
}
    public String ausgeben(){
        return name + ", " + vorname;
    }
}
