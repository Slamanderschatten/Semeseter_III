using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.InputSystem;
using Vector2 = UnityEngine.Vector2;
using Vector3 = UnityEngine.Vector3;




/*
 *
 * Truck empty gibt die drehachse vor und sammelt alle objekte damit sie von einem skript aus kontrolliert werden können.
 *
 * b) es wird auf die position gesetzt an der der truck starten soll
 * c) für gar nix ( mit Rigidbody damit der truck nicht runter fällt)
 * d) sieht anderst aus
 * e) habs schon verbessert indem ich die achse verschoben hab
 */

namespace Truck
{
    public class TruckControl : MonoBehaviour
    {
        [Range(0.1f, 20f)]
        public float speed = 5f;
        [Range(10.0f, 100.0f)]
        public float turnSpeed = 40f;

        private List<GameObject> trunks;
        private int trunkNumber;
        
        private InputAction moveEingabe;

        private void Start()
        {
            moveEingabe = InputSystem.actions.FindAction("Move");

            trunks = GameObject.FindGameObjectsWithTag("Trunk").ToList();
        }


        void Update()
        {
            float verticalMove = moveEingabe.ReadValue<Vector2>().y;    
            float horizontalMove = moveEingabe.ReadValue<Vector2>().x;   
            transform.Translate(Vector3.forward * 
                (speed * Time.deltaTime * verticalMove));
            
            transform.Rotate(Vector3.up, (Time.deltaTime * verticalMove * horizontalMove * turnSpeed));
        }


        public bool AddTrunk()
        {
            if (trunkNumber >= trunks.Count)
                return false;

            trunks[trunkNumber++].GetComponent<Renderer>().enabled = true;
            return true;
        }
    }
}