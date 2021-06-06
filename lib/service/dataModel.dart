class dataModel{
  int infected;
  int dead;
  int recovered;
  String lastUpdatedMonth;
  String lastUpdatedDay;
  dataModel(int infected,int dead,int recovered,String lastUpdatedMonth,String lastUpdatedDay){
    this.dead = dead;
    this.infected = infected;
    this.recovered = recovered;
    this.lastUpdatedMonth = lastUpdatedMonth;
    this.lastUpdatedDay = lastUpdatedDay;
  }
}