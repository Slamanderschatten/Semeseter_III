using System;
using System.Numerics;
using UnityEngine;
using Vector3 = UnityEngine.Vector3;

namespace weapons
{
    public class Blaster : MonoBehaviour
    {
        public Transform laserOrigin;
        public float maxLaserLength = 30;
        public Light targetPointLight;
        
        
        private bool hitDetected;
        private Vector3 hitPos;
        private LineRenderer laser;


        private void Awake()
        {
            laser = GetComponent<LineRenderer>();
        }


        private void Update()
        {
            if (Physics.Raycast(laserOrigin.position, transform.forward, out RaycastHit hit))
            {
                hitDetected = true;
                hitPos = hit.point;
            }
            else
            {
                hitDetected = false;
                hitPos = laserOrigin.position + laserOrigin.forward * maxLaserLength;
            }
            
            laser.SetPosition(0, laserOrigin.position);
            laser.SetPosition(1, hitPos);
            targetPointLight.transform.position = hitPos;
        }


        void OnDrawGizmos()
        {
            if(hitDetected)
                Gizmos.color = Color.red;
            else
                Gizmos.color = Color.white;
            Gizmos.DrawRay(laserOrigin.position, transform.forward * 1000f);
        }
    }
}