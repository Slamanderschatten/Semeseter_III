public class Fahrrad {
    protected String modell;
    protected Person besitzer;
    private Rahmen rahmen;

    public Fahrrad(String modell, Person besitzer, String rahmenArt) {
        this.modell = modell;
        this.besitzer = besitzer;
        this.rahmen = new Rahmen(rahmenArt);
        besitzer.setMeinFahrrad(this);
    }

    public String ausgeben(){
        return modell +
                ", Rahmenart " + rahmen.ausgeben() +
                ", Besitzer " + besitzer.ausgeben();
    }

    public void fahren(){

    }

    public class Rahmen {
        private String art;

        public Rahmen(String art) {
            this.art = art;
        }

        public String ausgeben(){
            return art;
        }
    }
}
