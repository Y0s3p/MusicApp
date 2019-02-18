//
//  FirstViewController.swift
//  MusicApp
//
//  Created by yosep on 13/02/2019.
//  Copyright © 2019 yosep. All rights reserved.
//

import UIKit
//AVFoundation nos permite trabajar con audio y video
import AVFoundation

var songs:[String] = []
//creamos un reproductor de audio
var audioPlayer = AVAudioPlayer()
//declaramos esta variable para saber que cancion esta actualmente
var thisSong = 0
//para evitar reproducir una cancion cuando el reproductor esta vacio creamos la siguiente variable
var audioStuffed = false

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //declaramos el numero de filas que necesitamos que equildra al numero de canciones en el array songs
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //declaramos que es lo que queremos mostrar en la tabla
        let cell = UITableViewCell(style: .default,  reuseIdentifier: "cell")
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //vamos a registrar cuando el usuario pulse sobre un elemento
        //cuando un usuario pulse sobre un elemento recogemos el nombre y reproducimos la cancion con ese nombre
        
        do
        {
            //vamos a encontrar la ruta por el nombre de la cancion
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            //cogemos el contenido de la variable audioPath y lo introducimos en el reproductor de audio
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            //obtenemos y almacenamos el numero de la cancion actual
            thisSong = indexPath.row
            //gracias a este booleano comprobamos que hay canciones en el reproductor
            audioStuffed = true
        }
        catch
        {
            print("ERROR")
        }
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gettingSongName()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func gettingSongName()
    {
        //Vamos a obtener la ruta de los archivos que utilizaremos
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        //Recorremos todos lo archivos en la carpeta
        //Lo hacemos en un do catch por si no funciona atrapar los errores
        do
        {
            //En la variable songPath tenemos el nombre de todos los archivos
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            //por cada archivo en songPath vamos a obtener su el string de su URL
            for song in songPath
            {
                var mySong = song.absoluteString
                
                //Comprobamos que contiene un .mp3 para comprobar que sea una cancion
                if mySong.contains(".mp3")
                {
                    //vamos a crear un array para encontrar y guardar el nombre de las canciones
                    //utilizamos la / para separar ya que detras de la ultima obtenemos el nombre de la cancion
                    let findString = mySong.components(separatedBy: "/")
                    //ya tenemos el nombre de la cancion de cada una de las urls
                    mySong = findString[findString.count-1]
                    //en el nombre de la cancion todavia aparecen caracteres extranios vamos a eliminarlos
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    
                    //vamos a aniadir cada cancion al array
                    songs.append(mySong)
                }
                
            }
            //vamos a actualizar la tabla con el nombre de las canciones
            myTableView.reloadData()
        }
        catch
        {
            
        }
    }
    
}

