using Unity.VisualScripting;
using UnityEngine;

namespace tv
{
    public class Button : MonoBehaviour
    {
        public int buttonIndex;
        public Material mat;
     
        void OnMouseDown()
        {
            FindObjectsByType<TV>(FindObjectsSortMode.None)[0].GetComponent<TV>().ButtonTipped(buttonIndex, mat);
        }
    }
}