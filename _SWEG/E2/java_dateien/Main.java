
public class Main {
    public static void main(String[] args) {
        Person p = new Person("Hagel", "Georg");
        Fahrrad f = new Fahrrad("Herrenfahrrad", p, "Fully");
        p.fahrradFahren();
        System.out.println(f.ausgeben());
    }
}