using UnityEngine;
using UnityEngine.Video;

namespace tv
{
    public class TV : MonoBehaviour
    {
        
        public Material green;
        public Material red;
        public Material yellow;
        public Material blue;
        
        private int progress;
        
        private VideoPlayer videoPlayer;
        
        
        public void ButtonTipped(string name)
        {
            Renderer rend = GetComponent<Renderer>();
            switch(name)
            {
                case "Gelb":
                    rend.material = yellow;
                    Debug.Log("Gelb");
                    progress = 1;
                    break;
                case "Grün":
                    rend.material = green;
                    Debug.Log("Grün");
                    if(progress == 1)
                        progress = 2;
                    break;
                case "Rot":
                    rend.material = red;
                    Debug.Log("Rot");
                    if(progress == 2)
                        progress = 3;
                    break;
                case "Blau":
                    rend.material = blue;
                    Debug.Log("Blau");
                    if(progress == 3)
                    {
                        VideoPlayer player = GetComponent<VideoPlayer>();
                        player.enabled = true;
                        player.Play();
                    }
                    break;
                
            }
            
            
        }
        
        
        
    }
}