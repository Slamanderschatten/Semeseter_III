using avatar;
using UnityEngine;
using UnityEngine.InputSystem;

namespace cams
{
    public class CamManager : MonoBehaviour
    {
        public enum CamMode
        {
            FirstPerson = 1,
            SecondPerson = 2,
            ThirdPerson = 3,
        }
        
        
        public Knight avatar;
        public Camera firstPersonCam;
        public Camera secondPersonCam;
        public Camera thirdPersonCam;
        [Header("first Person Cam")]
        public float mouseXMultiplier = 0.5f;
        [Header("second Person Cam")]
        public float scrollIntensity = 0.1f;
        public float maxFieldOfView = 100;
        public float minFieldOfView = 10;
        
        private CamMode camMode = CamMode.SecondPerson;
        private Vector3 dragOrigin;


        void Awake()
        {
            camMode = CamMode.ThirdPerson;
            firstPersonCam.enabled = false;
            secondPersonCam.enabled = false;
            thirdPersonCam.enabled = true;
        }



        void Update()
        {
            if (Keyboard.current.digit1Key.wasPressedThisFrame)
            {
                camMode =  CamMode.FirstPerson;
                firstPersonCam.enabled = true;
                secondPersonCam.enabled = false;
                thirdPersonCam.enabled = false;
            }
            else if (Keyboard.current.digit2Key.wasPressedThisFrame)
            {
                camMode = CamMode.SecondPerson;
                firstPersonCam.enabled = false;
                secondPersonCam.enabled = true;
                thirdPersonCam.enabled = false;
            }
            else if (Keyboard.current.digit3Key.wasPressedThisFrame)
            {
                camMode = CamMode.ThirdPerson;
                firstPersonCam.enabled = false;
                secondPersonCam.enabled = false;
                thirdPersonCam.enabled = true;
            }
            
            SecondPersonControl();
            FirstPersonControl();
        }
        
        
        
        
        
        
        
        private void SecondPersonControl()
        {
            
            
            if(camMode == CamMode.SecondPerson)
            {
                if (Mouse.current.rightButton.isPressed) //Während des Ziehens um Differenz verschieben
                {
                    Ray ray = secondPersonCam.ScreenPointToRay(Input.mousePosition);
                    RaycastHit hit;
                    if (!Physics.Raycast(ray, out hit)) return; //abbruch wenn nix getroffen
                    if (Mouse.current.rightButton.wasPressedThisFrame) //Wenn erstmals gedrückt Startpos merken
                    {
                        dragOrigin = hit.point;
                    }

                    Vector3 diff = dragOrigin - hit.point;
                    secondPersonCam.transform.position += diff;
                }
                
                float scrollMultiplier = -Mouse.current.scroll.ReadValue().y;
                if(Keyboard.current.numpadPlusKey.wasPressedThisFrame)
                    scrollMultiplier = -1;
                else if(Keyboard.current.numpadMinusKey.wasPressedThisFrame)
                    scrollMultiplier = 1;
                
                secondPersonCam.fieldOfView += scrollMultiplier * scrollIntensity;
                secondPersonCam.fieldOfView = Mathf.Clamp(secondPersonCam.fieldOfView, minFieldOfView, maxFieldOfView);
                    
            }
        }
        
        
        
        
        
        
        
        private void FirstPersonControl()
        {
            
            if(camMode == CamMode.FirstPerson)
            {
                if (Mouse.current.rightButton.isPressed) //Während des Ziehens um Differenz verschieben
                {
                    float mouseMoveX = Mouse.current.delta.ReadValue().x;
                    
                    avatar.transform.Rotate(0f, mouseMoveX * mouseXMultiplier, 0f);
                }  
            }
        }
        
        
        
        
    }
}