using System;
using UnityEngine;
using UnityEngine.Video;

namespace tv
{
    public class TV : MonoBehaviour
    {

        public Material startMaterial;

        private string[] colors = new[] { "yellow", "green", "red", "blue" };
        private int[] sequence = new int[] {-1, -1, -1, -1};
        private int[] progress = new int[4];
        private int progressIndex;
        
        
        public void ButtonTipped(int button, Material mat)
        {
            Renderer rend = GetComponent<Renderer>();
            rend.material = mat;
            Debug.Log("Button pressed: " + progressIndex + " = " +  colors[button]);
            
            if (sequence[3] == -1)
            {
                //store sequence
                sequence[progressIndex++] = button;
                if (progressIndex == 4)
                {
                    //sequence ready
                    Debug.Log("Sequence is " + colors[sequence[0]] + ", " + colors[sequence[1]] + ", " + colors[sequence[2]] + ", " +
                              colors[sequence[3]]);
                    rend.material = startMaterial;
                    progressIndex = 0;
                }
            }
            else
            {
                //ask progress
                progress[progressIndex++] = button;
                if (progressIndex == 4)
                {
                    //progress end
                    bool progressOk = true;
                    for (int j = 0; j < 4; j++)
                    {
                        if(progress[j] != sequence[j])
                        {
                            progressOk = false;
                            break;
                        }
                    }

                    if (progressOk)
                    {
                        VideoPlayer videoPlayer = GetComponent<VideoPlayer>();
                        videoPlayer.enabled = true;
                        videoPlayer.Play();
                        progressIndex = 0;
                    }
                    else
                    {
                        rend.material = startMaterial;
                        progressIndex = 0;
                    }
                }
                
            }
            
            
            
            
        }
        
        
        
    }
}