class Usermodel{
    final String? id;
    final String name;
    final String phone;
    final String password;
    const Usermodel({
      this.id,
      required this.name,
      required this.phone,
      required this.password
    });
    toJson(){
      return{
        "name":name,
        "phone":phone,
        "password":password,
      };
    }
}