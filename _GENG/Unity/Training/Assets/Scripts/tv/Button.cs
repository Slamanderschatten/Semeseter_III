using Unity.VisualScripting;
using UnityEngine;

namespace tv
{
    public class Button : MonoBehaviour
    {
     
        void OnMouseDown()
        {
            FindObjectsByType<TV>(FindObjectsSortMode.None)[0].GetComponent<TV>().ButtonTipped(gameObject.name);
        }
    }
}