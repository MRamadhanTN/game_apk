import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool isDarkMode = false;
  bool isNotificationsEnabled = true;

  Color hexaColor(String hex){
    hex = hex.replaceAll('#', ''); //hapus hex
    if(hex.length == 6){
      hex = 'FF$hex';
    }
    return Color(int.parse(hex,radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_rounded,color: Colors.white),
        ),
        backgroundColor: hexaColor('#16C47F'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Bagian Header Profil
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: hexaColor('#16C47F'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Ramadhan",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "ramadhan@example.com",
                      style: GoogleFonts.poppins(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              // Pengaturan Umum
              ListTile(
                leading: Icon(
                  Icons.person, color: hexaColor('#16C47F'),
                ),
                title: Text(
                  "Ubah Nama",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.email, color: hexaColor('#16C47F')),
                title: Text(
                  "Ubah Email",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.lock, color: hexaColor('#16C47F')),
                title: Text(
                  "Ubah Password",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              Divider(),

              // Pengaturan Aplikasi
              SwitchListTile(
                activeColor: hexaColor('#16C47F'),
                title: Text(
                  isDarkMode ? "Mode Terang" : "Mode Gelap",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
                secondary: Icon(
                  Icons.dark_mode,
                  color: hexaColor('#16C47F'),
                ),
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              SwitchListTile(
                activeColor: hexaColor('#16C47F'),
                title: Text(
                  "Notifikasi",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
                secondary: Icon(Icons.notifications, color: hexaColor('#16C47F')),
                value: isNotificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    isNotificationsEnabled = value;
                  });
                },
              ),

              // Logout Button
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hexaColor('D84040'),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Logout", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
