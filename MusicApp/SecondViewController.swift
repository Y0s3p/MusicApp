//
//  SecondViewController.swift
//  MusicApp
//
//  Created by yosep on 13/02/2019.
//  Copyright © 2019 yosep. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBAction func play(_ sender: Any)
    {
        if audioStuffed == true && audioPlayer.isPlaying == false
        {
            audioPlayer.play()
        }
    }
    
    @IBAction func pause(_ sender: Any)
    {
        if audioStuffed == true && audioPlayer.isPlaying
        {
            audioPlayer.pause()
        }
    }
    
    @IBAction func prev(_ sender: Any)
    {
        //controlamos que no se salga del array indicandole que mientras sea distinto a 0 puede ejecutarse y el reproductor no este vacio
        if thisSong != 0 && audioStuffed == true
        {
            //llamamos a la funcion playThis y le pasamos el valor del array songs actual + 1
            playthis(thisOne: songs[thisSong-1])
            //actualizamos el valor de la cancion actual
            thisSong -= 1
            //Hacemos que en la etiqueta nos muestre el nombre de la cancion actual
            label.text = songs[thisSong]
        }
        else
        {
            
        }
        
    }
    
    @IBAction func next(_ sender: Any)
    {
        //controlamos que no se salga del array para que no crashe la app y el reproductor no este vacio
        if thisSong < songs.count-1 && audioStuffed == true
        {
            //llamamos a la funcion playThis y le pasamos el valor del array songs actual + 1
            playthis(thisOne: songs[thisSong+1])
            //actualizamos el valor de la cancion actual
            thisSong += 1
            //Hacemos que en la etiqueta nos muestre el nombre de la cancion actual
            label.text = songs[thisSong]
        }
        else
        {
            
        }
        
    }
    
    @IBAction func slider(_ sender: UISlider)
    {
        if audioStuffed == true
        {
            //declaramos que el volumen va a ser igual al valor del slider el cual el minimo es 0 y el maximo es 1
            audioPlayer.volume = sender.value
        }
        
        
    }
    
    func playthis(thisOne: String)
    {
        //Esta funcion va a recibir el nombre de la funcion y despues deberia reproducir dicha cancion
        do
        {
            //vamos a encontrar la ruta por el nombre de la cancion
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            //cogemos el contenido de la variable audioPath y lo introducimos en el reproductor de audio
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            
        }
        catch
        {
            print("ERROR")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Hacemos que en la etiqueta nos muestre el nombre de la cancion actual
        label.text = songs[thisSong]
        playBtn.layer.cornerRadius = 5
        pauseBtn.layer.cornerRadius = 5
        prevBtn.layer.cornerRadius = 5
        nextBtn.layer.cornerRadius = 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

