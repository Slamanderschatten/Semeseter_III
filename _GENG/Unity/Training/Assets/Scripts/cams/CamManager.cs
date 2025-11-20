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
        
        
        public Camera firstPersonCam;
        public Camera secondPersonCam;
        public Camera thirdPersonCam;
        
        private CamMode camMode = CamMode.SecondPerson;


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
        }
    }
}